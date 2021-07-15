import 'package:flutter/material.dart';
import 'package:tictactoe_battle/tictactoe_battle.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

const List<Color> _filedColors = <Color>[
  Colors.white,
  Colors.greenAccent,
  Colors.yellowAccent,
];

const Map<WinLine, List<Position>> _winLines = {
  WinLine.WIN_LINE_1: <Position>[Position.POSITION_X0Y0, Position.POSITION_X1Y0, Position.POSITION_X2Y0],
  WinLine.WIN_LINE_2: <Position>[Position.POSITION_X0Y1, Position.POSITION_X1Y1, Position.POSITION_X2Y1],
  WinLine.WIN_LINE_3: <Position>[Position.POSITION_X0Y2, Position.POSITION_X1Y2, Position.POSITION_X2Y2],
  WinLine.WIN_LINE_4: <Position>[Position.POSITION_X0Y0, Position.POSITION_X0Y1, Position.POSITION_X0Y2],
  WinLine.WIN_LINE_5: <Position>[Position.POSITION_X1Y0, Position.POSITION_X1Y1, Position.POSITION_X1Y2],
  WinLine.WIN_LINE_6: <Position>[Position.POSITION_X2Y0, Position.POSITION_X2Y1, Position.POSITION_X2Y2],
  WinLine.WIN_LINE_7: <Position>[Position.POSITION_X0Y0, Position.POSITION_X1Y1, Position.POSITION_X2Y2],
  WinLine.WIN_LINE_8: <Position>[Position.POSITION_X2Y0, Position.POSITION_X1Y1, Position.POSITION_X0Y2],
};

class FieldCard extends StatefulWidget {
  final bool Function() _callback;
  final Position _position;
  final PieceStack _stack;
  final WinLine _winLine;
  final bool _picked;

  FieldCard(this._position, this._callback, this._stack, this._winLine, this._picked);

  @override
  _FieldCardState createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> with TickerProviderStateMixin {
  CustomAnimationControl control = CustomAnimationControl.playFromStart;
  String latestImagePath = "";

  @override
  Widget build(BuildContext context) {
    final imagePath = _imagePath();
    if (latestImagePath != imagePath) {
      control = CustomAnimationControl.playFromStart;
      latestImagePath = imagePath;
    }

    final anime = CustomAnimation<double>(
      control: control,
      tween: (3.0).tweenTo(1.0),
      duration: 400.milliseconds,
      curve: Curves.easeIn,
      builder: (context, child, value) {
        if (value == 1.0) {
          control = CustomAnimationControl.stop;
        }
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Image(
        width: 150,
        height: 120,
        fit: BoxFit.scaleDown,
        image: AssetImage(imagePath),
      ),
    );

    return Material(
      elevation: 4,
      child: GestureDetector(
        child: Card(
          child: anime,
          color: _fieldColor(),
        ),
        onTap: () => widget._callback(),
      ),
    );
  }

  String _imagePath() {
    if (widget._stack.l == Player.PLAYER_A) {
      return "images/brave.png";
    }
    if (widget._stack.l == Player.PLAYER_B) {
      return "images/dragon.png";
    }
    if (widget._stack.m == Player.PLAYER_A) {
      return "images/knight.png";
    }
    if (widget._stack.m == Player.PLAYER_B) {
      return "images/skeleton.png";
    }
    if (widget._stack.s == Player.PLAYER_A) {
      return "images/bard.png";
    }
    if (widget._stack.s == Player.PLAYER_B) {
      return "images/slime.png";
    }
    return "images/nothing.png";
  }

  Color _fieldColor() {
    if (widget._winLine != WinLine.WIN_LINE_UNKNOWN) {
      final winLine = _winLines[widget._winLine];
      if (winLine!.contains(widget._position)) {
        return Colors.orangeAccent;
      }
    }

    if (widget._picked) {
      return Colors.white24;
    }

    if (widget._stack.l != Player.PLAYER_UNKNOWN) {
      return _filedColors[widget._stack.l.value];
    }

    if (widget._stack.m != Player.PLAYER_UNKNOWN) {
      return _filedColors[widget._stack.m.value];
    }

    return _filedColors[widget._stack.s.value];
  }
}
