import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_battle_frontend/commons/logger/logger.dart';
import 'package:tictactoe_battle_frontend/services/battle_service.dart';
import 'package:tictactoe_battle_frontend/services/login_service.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';

part 'battle_controller.freezed.dart';

@freezed
class BattleControllerState with _$BattleControllerState {
  const factory BattleControllerState({
    required String roomID,
    required BattleState battleState,
    required Player player,
    required String playerAID,
    required String playerBID,
    required Holding holding,
    required List<PieceStack> field,
    required WinLine winLine,
    required bool operable,
    required Position pickedPosition,
    required Piece pickedFieldPiece,
    required Piece pickedHoldingPiece,
  }) = _BattleControllerState;
}

class BattleController extends StateNotifier<BattleControllerState> {
  final BattleService _battleSvc;
  final LoginService _loginSvc;
  final battleIDController = TextEditingController();
  RemoveListener? _rmListener;

  BattleController(BattleService battle, LoginService login)
      : _battleSvc = battle,
        _loginSvc = login,
        super(
          BattleControllerState(
            roomID: "",
            battleState: BattleState.BATTLE_STATE_UNKNOWN,
            player: Player.PLAYER_UNKNOWN,
            playerAID: "",
            playerBID: "",
            holding: new Holding(),
            field: [],
            winLine: WinLine.WIN_LINE_UNKNOWN,
            operable: false,
            pickedPosition: Position.POSITION_UNDEFINED,
            pickedFieldPiece: Piece.PIECE_UNKNOWN,
            pickedHoldingPiece: Piece.PIECE_UNKNOWN,
          ),
        );

  Future<void> subscribe() async {
    final loginID = await _loginSvc.loginID();
    final roomID = await _battleSvc.reservationRoomID();

    final isNewConnection = await _battleSvc.enterRoom(loginID!, roomID);
    if (!isNewConnection) {
      return;
    }

    _rmListener = _battleSvc.addListener((battle) {
      state = state.copyWith(
        roomID: battle.roomId,
        battleState: battle.state,
        player: battle.player,
        playerAID: battle.playerAId,
        playerBID: battle.playerBId,
        holding: battle.holding,
        field: battle.field,
        winLine: battle.winLine,
        operable: battle.state == BattleState.BATTLE_STATE_PLAYER_TURN,
        pickedPosition: battle.pickedPosition,
        pickedFieldPiece: battle.pickedPiece,
      );
    });
  }

  Future<void> declaration() async {
    if (state.battleState != BattleState.BATTLE_STATE_MEETING) {
      return;
    }
    final loginID = await _loginSvc.loginID() ?? "";
    _battleSvc.declaration(state.roomID, loginID);
  }

  List<String> infoMessages() {
    final ret = <String>["", "", ""];

    if (state.playerAID != "") {
      ret[1] = sprintf("[ 人間チーム ] %s", [state.playerAID]);
    }
    if (state.playerBID != "") {
      ret[2] = sprintf("[ 怪物チーム ] %s", [state.playerBID]);
    }

    if (state.player == Player.PLAYER_AUDIENCE) {
      switch (state.battleState) {
        case BattleState.BATTLE_STATE_MEETING:
          ret[0] = "プレイヤー募集中です";
          break;
        case BattleState.BATTLE_STATE_PLAYER_TURN:
          ret[0] = state.playerAID + "のターンです";
          break;
        case BattleState.BATTLE_STATE_PLAYER_TURN_PICKED:
          ret[0] = state.playerAID + "のターンです [ Picked ]";
          break;
        case BattleState.BATTLE_STATE_OPPONENT_TURN:
          ret[0] = state.playerBID + "のターンです";
          break;
        case BattleState.BATTLE_STATE_OPPONENT_TURN_PICKED:
          ret[0] = state.playerBID + "のターンです [ Picked ]";
          break;
        case BattleState.BATTLE_STATE_WIN:
          ret[0] = state.playerAID + "の勝ち!!";
          break;
        case BattleState.BATTLE_STATE_LOSE:
          ret[0] = state.playerBID + "の勝ち!!";
          break;
      }

      return ret;
    }

    switch (state.battleState) {
      case BattleState.BATTLE_STATE_MEETING:
        ret[0] = "プレイヤー募集中です";
        break;
      case BattleState.BATTLE_STATE_PLAYER_TURN:
        ret[0] = "あなたのターンです";
        break;
      case BattleState.BATTLE_STATE_PLAYER_TURN_PICKED:
        ret[0] = "あなたのターンです [ Picked ]";
        break;
      case BattleState.BATTLE_STATE_OPPONENT_TURN:
        ret[0] = "相手のターンです";
        break;
      case BattleState.BATTLE_STATE_OPPONENT_TURN_PICKED:
        ret[0] = "相手のターンです [ Picked ]";
        break;
      case BattleState.BATTLE_STATE_WIN:
        ret[0] = "You win !!";
        break;
      case BattleState.BATTLE_STATE_LOSE:
        ret[0] = "You lose ..";
        break;
    }

    return ret;
  }

  void pickFromHolding(Piece piece) {
    if (state.battleState != BattleState.BATTLE_STATE_PLAYER_TURN) {
      return;
    }

    if (piece == state.pickedHoldingPiece) {
      state = state.copyWith(pickedHoldingPiece: Piece.PIECE_UNKNOWN);
      return;
    }

    switch (piece) {
      case Piece.PIECE_L:
        if (state.holding.l == 0) {
          return;
        }
        break;
      case Piece.PIECE_M:
        if (state.holding.m == 0) {
          return;
        }
        break;
      case Piece.PIECE_S:
        if (state.holding.s == 0) {
          return;
        }
        break;
      default:
        return;
    }

    state = state.copyWith(pickedHoldingPiece: piece);
  }

  bool fieldTouch(Position position) {
    if (state.player == Player.PLAYER_AUDIENCE) {
      return false;
    }

    switch (state.battleState) {
      case BattleState.BATTLE_STATE_PLAYER_TURN:
        // put picked holding piece
        if (state.pickedHoldingPiece != Piece.PIECE_UNKNOWN) {
          gLogger.d(sprintf(
            "status not to be processed. position: %s, battle_state: %s",
            [position, state.battleState],
          ));
          _battleSvc.attack(state.roomID, state.player, position, state.pickedHoldingPiece);
          state = state.copyWith(pickedHoldingPiece: Piece.PIECE_UNKNOWN);
          return true;
        }

        // pick piece from field
        final piece = _availablePiece(position);
        if (piece != null) {
          _battleSvc.pick(state.roomID, state.player, position, piece);
          return true;
        }
        break;

      case BattleState.BATTLE_STATE_PLAYER_TURN_PICKED:
        _battleSvc.attack(state.roomID, state.player, position, state.pickedFieldPiece);
        return true;
    }

    return false;
  }

  Piece? _availablePiece(Position position) {
    if (state.field.length == 0) {
      return null;
    }
    final stk = state.field[position.value];
    if (stk.l == state.player) {
      return Piece.PIECE_L;
    }
    if (stk.m == state.player) {
      return Piece.PIECE_M;
    }
    if (stk.s == state.player) {
      return Piece.PIECE_S;
    }

    return null;
  }

  Future<void> leave(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    await _battleSvc.leave(loginID!, state.roomID);
    Navigator.of(context).pushNamedAndRemoveUntil("/room", (_) => false);
  }

  Future<void> reset(BuildContext context) async {
    await _battleSvc.reset(state.roomID);
  }

  @override
  void dispose() {
    battleIDController.dispose();
    if (_rmListener != null) {
      _rmListener!();
    }
    gLogger.d("battle controller disposed");
    super.dispose();
  }
}
