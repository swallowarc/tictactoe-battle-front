import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';
import 'package:tictactoe_battle_frontend/providers.dart';
import 'package:tictactoe_battle_frontend/ui/battle/battle_controller.dart';
import 'package:tictactoe_battle_frontend/ui/battle/field_card.dart';

final StateNotifierProvider<BattleController, BattleControllerState> _controllerProvider = StateNotifierProvider(
    (ref) => BattleController(ref.read(battleServiceProvider.notifier), ref.read(loginServiceProvider.notifier)));

class BattleView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);
    final state = useProvider(_controllerProvider);

    controller.subscribe();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text(sprintf("Battle [room id: %s]", [state.roomID]))),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) {
              final List<PopupMenuEntry<int>> menuItems = [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "退室",
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "リセット",
                  ),
                ),
              ];
              return menuItems;
            },
            onSelected: (int idx) {
              switch (idx) {
                case 1:
                  controller.leave(context);
                  break;
                case 2:
                  controller.reset(context);
                  break;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: _buildView(context, state),
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context, BattleControllerState state) {
    if (state.battleState == BattleState.BATTLE_STATE_ERROR) {
      return Text("エラーが発生しました。退室してください。");
    }

    return Container(
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BattleText(),
          _BattleViewHolding(),
          _BattleViewField(),
        ],
      ),
    );
  }
}

class _BattleText extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);
    final info = controller.infoMessages();

    return Container(
      alignment: Alignment.centerLeft,
      width: 800,
      child: Material(
        elevation: 4,
        child: Card(
          child: Column(
            children: [
              _wrap(info[0]),
              _wrap(info[1]),
              _wrap(info[2]),
            ],
          ),
        ),
      ),
    );
  }

  Container _wrap(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Text(text),
    );
  }
}

class _BattleViewHolding extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);
    final state = useProvider(_controllerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          icon: Badge(
            animationType: BadgeAnimationType.slide,
            shape: BadgeShape.circle,
            badgeContent: Text(state.holding.s.toString()),
          ),
          label: const Text('Weak'),
          style: ElevatedButton.styleFrom(
            primary: state.pickedHoldingPiece == Piece.PIECE_S ? Colors.green : null,
          ),
          onPressed: state.operable && state.holding.s > 0 ? () => controller.pickFromHolding(Piece.PIECE_S) : null,
        ),
        ElevatedButton.icon(
          icon: Badge(
            animationType: BadgeAnimationType.slide,
            shape: BadgeShape.circle,
            badgeContent: Text(state.holding.m.toString()),
          ),
          label: const Text('Medium'),
          style: ElevatedButton.styleFrom(
            primary: state.pickedHoldingPiece == Piece.PIECE_M ? Colors.green : null,
          ),
          onPressed: state.operable && state.holding.m > 0 ? () => controller.pickFromHolding(Piece.PIECE_M) : null,
        ),
        ElevatedButton.icon(
          icon: Badge(
            animationType: BadgeAnimationType.slide,
            shape: BadgeShape.circle,
            badgeContent: Text(state.holding.l.toString()),
          ),
          label: const Text('Strong'),
          style: ElevatedButton.styleFrom(
            primary: state.pickedHoldingPiece == Piece.PIECE_L ? Colors.green : null,
          ),
          onPressed: state.operable && state.holding.l > 0 ? () => controller.pickFromHolding(Piece.PIECE_L) : null,
        ),
      ],
    );
  }
}

class _BattleViewField extends HookWidget {
  final List<FieldCard> fieldCards = [];

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);
    final state = useProvider(_controllerProvider);

    if (state.battleState == BattleState.BATTLE_STATE_MEETING) {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(Icons.whatshot),
              label: const Text('参戦'),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.black87,
                elevation: 3,
              ),
              onPressed: () {
                controller.declaration();
              },
            ),
          ),
        ),
      );
    }

    int i = 0;
    return Column(
      children: List<Widget>.generate(3, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(
            3,
            (index) {
              final pos = Position.values[i];
              final field = FieldCard(
                pos,
                () => controller.fieldTouch(pos),
                state.field[i],
                state.winLine,
                state.pickedPosition == pos,
              );
              final ret = Expanded(
                child: Container(
                  width: 150,
                  height: 120,
                  child: field,
                ),
              );
              i++;
              return ret;
            },
          ),
        );
      }),
    );
  }
}
