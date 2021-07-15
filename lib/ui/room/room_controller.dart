import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe_battle_frontend/services/battle_service.dart';
import 'package:tictactoe_battle_frontend/services/login_service.dart';

part 'room_controller.freezed.dart';

@freezed
class RoomControllerState with _$RoomControllerState {
  const factory RoomControllerState() = _RoomControllerState;
}

class RoomController extends StateNotifier<RoomControllerState> {
  final BattleService _battleSvc;
  final LoginService _loginSvc;
  final roomIDController = TextEditingController();

  RoomController(BattleService battle, LoginService login)
      : _battleSvc = battle,
        _loginSvc = login,
        super(RoomControllerState());

  Future<void> createRoom(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    final valid = await _battleSvc.createRoom(loginID);
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('部屋の作成に失敗しました。')));
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil("/battle", (_) => false);
  }

  Future<void> enterRoom(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    final valid = await _battleSvc.enterRoomReservation(loginID, roomIDController.text);
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ルームIDのが無効、または満室です')));
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil("/battle", (_) => false);
  }

  @override
  void dispose() {
    roomIDController.dispose();
    super.dispose();
  }
}
