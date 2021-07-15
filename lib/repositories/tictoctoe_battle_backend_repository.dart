import 'dart:async';

import 'package:tictactoe_battle_frontend/commons/retry/retry.dart';
import 'package:tictactoe_battle_frontend/domains/login_status.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';
import 'package:grpc/grpc_web.dart';
import 'package:retry/retry.dart';

const _retryOpt = RetryOptions(
  maxAttempts: 8,
  maxDelay: Duration(seconds: 5),
);

class TicTacToeBattleBackendRepository {
  GrpcWebClientChannel? _svcChan;
  TicTacToeBattleServiceClient? _svcCli;

  TicTacToeBattleBackendRepository(String serverURL) {
    _svcChan = GrpcWebClientChannel.xhr(Uri.parse(serverURL));
    _svcCli = TicTacToeBattleServiceClient(_svcChan!, options: CallOptions(timeout: Duration(seconds: 600)));
  }

  Future<String> login(LoginStatus status) async {
    final req = LoginRequest(
      login: Login(
        loginId: status.loginID,
        sessionId: status.sessionID,
      ),
    );

    try {
      final res = await _svcCli!.login(req);
      return res.login.sessionId;
    } catch (error) {
      print('failed to login rpc: $error');
      return Future.error(error);
    }
  }

  Future<String> createRoom() async {
    final res = await gRPCRetry(
      () => _svcCli!.createRoom(CreateRoomRequest()),
    );

    return res.roomId;
  }

  Future<bool> canEnterRoom(String loginID, roomID) async {
    return gRPCRetry(
      () => _svcCli!
          .canEnterRoom(CanEnterRoomRequest(
            loginId: loginID,
            roomId: roomID,
          ))
          .then((res) => res.canEnterRoom),
    );
  }

  Future<ResponseStream<BattleSituation>> enterRoom(String loginID, roomID) async {
    return gRPCRetry(
      () => _svcCli!.enterRoom(EnterRoomRequest(
        loginId: loginID,
        roomId: roomID,
      )),
    );
  }

  Future<void> declaration(String roomID, loginID) async {
    gRPCRetry(
      () => _svcCli!.declaration(DeclarationRequest(
        roomId: roomID,
        loginId: loginID,
      )),
    );
  }

  Future<void> attack(
    String roomID,
    Player player,
    Position position,
    Piece piece,
  ) async {
    gRPCRetry(
      () => _svcCli!.attack(AttackRequest(
        roomId: roomID,
        player: player,
        position: position,
        piece: piece,
      )),
    );
  }

  Future<void> pick(
    String roomID,
    Player player,
    Position position,
    Piece piece,
  ) async {
    gRPCRetry(
      () => _svcCli!.pick(PickRequest(
        roomId: roomID,
        player: player,
        position: position,
        piece: piece,
      )),
    );
  }

  Future<void> reset(String roomID) async {
    gRPCRetry(
      () => _svcCli!.resetBattle(ResetBattleRequest(
        roomId: roomID,
      )),
    );
  }

  Future<void> leaveRoom(String loginID, roomID) async {
    gRPCRetry(
      () => _svcCli!.leaveRoom(LeaveRoomRequest(
        loginId: loginID,
        roomId: roomID,
      )),
    );
  }

  void shutdown() {
    _svcChan!.shutdown();
  }
}
