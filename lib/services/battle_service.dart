import 'package:grpc/grpc_web.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:protobuf/protobuf.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';

import '/commons/errors/errors.dart';
import '/commons/logger/logger.dart';
import '/repositories/local_storage_repository.dart';
import '/repositories/tictactoe_battle_backend_repository.dart';

enum _battleStatus { In, Out }

class BattleService extends StateNotifier<BattleSituation> {
  final LocalStorageRepository _storageRepo;
  final TicTacToeBattleBackendRepository _svcRepo;

  String? roomID;
  ResponseStream<BattleSituation>? _stream;
  _battleStatus _status = _battleStatus.Out;

  BattleService(LocalStorageRepository storageRepo, TicTacToeBattleBackendRepository svcRepo)
      : _svcRepo = svcRepo,
        _storageRepo = storageRepo,
        super(BattleSituation(state: BattleState.BATTLE_STATE_MEETING));

  Future<bool> createRoom(String loginID) async {
    roomID = await _svcRepo.createRoom();
    if (roomID == null) {
      return false;
    }

    final valid = await enterRoomReservation(loginID, roomID);
    if (!valid) {
      return false;
    }

    return true;
  }

  Future<bool> enterRoomReservation(String loginID, roomID) async {
    final canEnterRoom = await _svcRepo.canEnterRoom(loginID, roomID);
    if (!canEnterRoom) {
      return false;
    }

    await _storageRepo.saveEnterRoomID(roomID);

    return true;
  }

  Future<String> reservationRoomID() async {
    final roomID = await _storageRepo.getEnterRoomID();
    return roomID;
  }

  Future<bool> enterRoom(String loginID, roomID) async {
    if (_status == _battleStatus.In && this.roomID == roomID) {
      return false;
    }

    this.roomID = roomID;
    _status = _battleStatus.In;

    gLogger.d("enter room");

    return await _enterRoom(loginID, roomID);
  }

  Future<bool> _enterRoom(String loginID, roomID) async {
    if (_status == _battleStatus.Out) {
      gLogger.d("_status = _battleStatus.Out");
      return false;
    }

    try {
      _stream = await _svcRepo.enterRoom(loginID, roomID);
    } catch (e, stack) {
      gLogger.e("failed to enterRoom", e, stack);
      _status = _battleStatus.Out;

      return false;
    }

    // stream.listenはtryの中に記載してもcatchされないので独自にエラーハンドリングする必要がある
    _stream?.listen((battle) {
      gLogger.d(battle.toProto3Json());
      state = battle;
    }, onError: (err) {
      if (isGRPCErrorCodeToRetry(err)) {
        gLogger.d("retry enter room");
        _enterRoom(loginID, roomID);

        return;
      }

      final newState = state.rebuild((s) {
        s.state = BattleState.BATTLE_STATE_ERROR;
      });
      state = newState;
      throw err;
    });

    return true;
  }

  Future<void> declaration(
    String roomID,
    String loginID,
  ) async {
    _svcRepo.declaration(roomID, loginID);
  }

  Future<void> attack(
    String roomID,
    Player player,
    Position position,
    Piece piece,
  ) async {
    _svcRepo.attack(roomID, player, position, piece);
  }

  Future<void> pick(
    String roomID,
    Player player,
    Position position,
    Piece piece,
  ) async {
    _svcRepo.pick(roomID, player, position, piece);
  }

  Future<void> reset(String roomID) async {
    try {
      _svcRepo.reset(roomID);
    } catch (e, stack) {
      gLogger.e("failed to reset", e, stack);
    }
  }

  Future<void> leave(String loginID, roomID) async {
    _status = _battleStatus.Out;
    _storageRepo.deleteEnterRoomID();

    try {
      _svcRepo.leaveRoom(loginID, roomID);
    } catch (e, stack) {
      gLogger.e("failed to leaveRoom", e, stack);
    }
  }
}
