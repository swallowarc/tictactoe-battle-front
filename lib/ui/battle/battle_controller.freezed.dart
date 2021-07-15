// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'battle_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BattleControllerStateTearOff {
  const _$BattleControllerStateTearOff();

  _BattleControllerState call(
      {required String roomID,
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
      required Piece pickedHoldingPiece}) {
    return _BattleControllerState(
      roomID: roomID,
      battleState: battleState,
      player: player,
      playerAID: playerAID,
      playerBID: playerBID,
      holding: holding,
      field: field,
      winLine: winLine,
      operable: operable,
      pickedPosition: pickedPosition,
      pickedFieldPiece: pickedFieldPiece,
      pickedHoldingPiece: pickedHoldingPiece,
    );
  }
}

/// @nodoc
const $BattleControllerState = _$BattleControllerStateTearOff();

/// @nodoc
mixin _$BattleControllerState {
  String get roomID => throw _privateConstructorUsedError;
  BattleState get battleState => throw _privateConstructorUsedError;
  Player get player => throw _privateConstructorUsedError;
  String get playerAID => throw _privateConstructorUsedError;
  String get playerBID => throw _privateConstructorUsedError;
  Holding get holding => throw _privateConstructorUsedError;
  List<PieceStack> get field => throw _privateConstructorUsedError;
  WinLine get winLine => throw _privateConstructorUsedError;
  bool get operable => throw _privateConstructorUsedError;
  Position get pickedPosition => throw _privateConstructorUsedError;
  Piece get pickedFieldPiece => throw _privateConstructorUsedError;
  Piece get pickedHoldingPiece => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BattleControllerStateCopyWith<BattleControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleControllerStateCopyWith<$Res> {
  factory $BattleControllerStateCopyWith(BattleControllerState value,
          $Res Function(BattleControllerState) then) =
      _$BattleControllerStateCopyWithImpl<$Res>;
  $Res call(
      {String roomID,
      BattleState battleState,
      Player player,
      String playerAID,
      String playerBID,
      Holding holding,
      List<PieceStack> field,
      WinLine winLine,
      bool operable,
      Position pickedPosition,
      Piece pickedFieldPiece,
      Piece pickedHoldingPiece});
}

/// @nodoc
class _$BattleControllerStateCopyWithImpl<$Res>
    implements $BattleControllerStateCopyWith<$Res> {
  _$BattleControllerStateCopyWithImpl(this._value, this._then);

  final BattleControllerState _value;
  // ignore: unused_field
  final $Res Function(BattleControllerState) _then;

  @override
  $Res call({
    Object? roomID = freezed,
    Object? battleState = freezed,
    Object? player = freezed,
    Object? playerAID = freezed,
    Object? playerBID = freezed,
    Object? holding = freezed,
    Object? field = freezed,
    Object? winLine = freezed,
    Object? operable = freezed,
    Object? pickedPosition = freezed,
    Object? pickedFieldPiece = freezed,
    Object? pickedHoldingPiece = freezed,
  }) {
    return _then(_value.copyWith(
      roomID: roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String,
      battleState: battleState == freezed
          ? _value.battleState
          : battleState // ignore: cast_nullable_to_non_nullable
              as BattleState,
      player: player == freezed
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      playerAID: playerAID == freezed
          ? _value.playerAID
          : playerAID // ignore: cast_nullable_to_non_nullable
              as String,
      playerBID: playerBID == freezed
          ? _value.playerBID
          : playerBID // ignore: cast_nullable_to_non_nullable
              as String,
      holding: holding == freezed
          ? _value.holding
          : holding // ignore: cast_nullable_to_non_nullable
              as Holding,
      field: field == freezed
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as List<PieceStack>,
      winLine: winLine == freezed
          ? _value.winLine
          : winLine // ignore: cast_nullable_to_non_nullable
              as WinLine,
      operable: operable == freezed
          ? _value.operable
          : operable // ignore: cast_nullable_to_non_nullable
              as bool,
      pickedPosition: pickedPosition == freezed
          ? _value.pickedPosition
          : pickedPosition // ignore: cast_nullable_to_non_nullable
              as Position,
      pickedFieldPiece: pickedFieldPiece == freezed
          ? _value.pickedFieldPiece
          : pickedFieldPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      pickedHoldingPiece: pickedHoldingPiece == freezed
          ? _value.pickedHoldingPiece
          : pickedHoldingPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
    ));
  }
}

/// @nodoc
abstract class _$BattleControllerStateCopyWith<$Res>
    implements $BattleControllerStateCopyWith<$Res> {
  factory _$BattleControllerStateCopyWith(_BattleControllerState value,
          $Res Function(_BattleControllerState) then) =
      __$BattleControllerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String roomID,
      BattleState battleState,
      Player player,
      String playerAID,
      String playerBID,
      Holding holding,
      List<PieceStack> field,
      WinLine winLine,
      bool operable,
      Position pickedPosition,
      Piece pickedFieldPiece,
      Piece pickedHoldingPiece});
}

/// @nodoc
class __$BattleControllerStateCopyWithImpl<$Res>
    extends _$BattleControllerStateCopyWithImpl<$Res>
    implements _$BattleControllerStateCopyWith<$Res> {
  __$BattleControllerStateCopyWithImpl(_BattleControllerState _value,
      $Res Function(_BattleControllerState) _then)
      : super(_value, (v) => _then(v as _BattleControllerState));

  @override
  _BattleControllerState get _value => super._value as _BattleControllerState;

  @override
  $Res call({
    Object? roomID = freezed,
    Object? battleState = freezed,
    Object? player = freezed,
    Object? playerAID = freezed,
    Object? playerBID = freezed,
    Object? holding = freezed,
    Object? field = freezed,
    Object? winLine = freezed,
    Object? operable = freezed,
    Object? pickedPosition = freezed,
    Object? pickedFieldPiece = freezed,
    Object? pickedHoldingPiece = freezed,
  }) {
    return _then(_BattleControllerState(
      roomID: roomID == freezed
          ? _value.roomID
          : roomID // ignore: cast_nullable_to_non_nullable
              as String,
      battleState: battleState == freezed
          ? _value.battleState
          : battleState // ignore: cast_nullable_to_non_nullable
              as BattleState,
      player: player == freezed
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      playerAID: playerAID == freezed
          ? _value.playerAID
          : playerAID // ignore: cast_nullable_to_non_nullable
              as String,
      playerBID: playerBID == freezed
          ? _value.playerBID
          : playerBID // ignore: cast_nullable_to_non_nullable
              as String,
      holding: holding == freezed
          ? _value.holding
          : holding // ignore: cast_nullable_to_non_nullable
              as Holding,
      field: field == freezed
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as List<PieceStack>,
      winLine: winLine == freezed
          ? _value.winLine
          : winLine // ignore: cast_nullable_to_non_nullable
              as WinLine,
      operable: operable == freezed
          ? _value.operable
          : operable // ignore: cast_nullable_to_non_nullable
              as bool,
      pickedPosition: pickedPosition == freezed
          ? _value.pickedPosition
          : pickedPosition // ignore: cast_nullable_to_non_nullable
              as Position,
      pickedFieldPiece: pickedFieldPiece == freezed
          ? _value.pickedFieldPiece
          : pickedFieldPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      pickedHoldingPiece: pickedHoldingPiece == freezed
          ? _value.pickedHoldingPiece
          : pickedHoldingPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
    ));
  }
}

/// @nodoc

class _$_BattleControllerState implements _BattleControllerState {
  const _$_BattleControllerState(
      {required this.roomID,
      required this.battleState,
      required this.player,
      required this.playerAID,
      required this.playerBID,
      required this.holding,
      required this.field,
      required this.winLine,
      required this.operable,
      required this.pickedPosition,
      required this.pickedFieldPiece,
      required this.pickedHoldingPiece});

  @override
  final String roomID;
  @override
  final BattleState battleState;
  @override
  final Player player;
  @override
  final String playerAID;
  @override
  final String playerBID;
  @override
  final Holding holding;
  @override
  final List<PieceStack> field;
  @override
  final WinLine winLine;
  @override
  final bool operable;
  @override
  final Position pickedPosition;
  @override
  final Piece pickedFieldPiece;
  @override
  final Piece pickedHoldingPiece;

  @override
  String toString() {
    return 'BattleControllerState(roomID: $roomID, battleState: $battleState, player: $player, playerAID: $playerAID, playerBID: $playerBID, holding: $holding, field: $field, winLine: $winLine, operable: $operable, pickedPosition: $pickedPosition, pickedFieldPiece: $pickedFieldPiece, pickedHoldingPiece: $pickedHoldingPiece)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BattleControllerState &&
            (identical(other.roomID, roomID) ||
                const DeepCollectionEquality().equals(other.roomID, roomID)) &&
            (identical(other.battleState, battleState) ||
                const DeepCollectionEquality()
                    .equals(other.battleState, battleState)) &&
            (identical(other.player, player) ||
                const DeepCollectionEquality().equals(other.player, player)) &&
            (identical(other.playerAID, playerAID) ||
                const DeepCollectionEquality()
                    .equals(other.playerAID, playerAID)) &&
            (identical(other.playerBID, playerBID) ||
                const DeepCollectionEquality()
                    .equals(other.playerBID, playerBID)) &&
            (identical(other.holding, holding) ||
                const DeepCollectionEquality()
                    .equals(other.holding, holding)) &&
            (identical(other.field, field) ||
                const DeepCollectionEquality().equals(other.field, field)) &&
            (identical(other.winLine, winLine) ||
                const DeepCollectionEquality()
                    .equals(other.winLine, winLine)) &&
            (identical(other.operable, operable) ||
                const DeepCollectionEquality()
                    .equals(other.operable, operable)) &&
            (identical(other.pickedPosition, pickedPosition) ||
                const DeepCollectionEquality()
                    .equals(other.pickedPosition, pickedPosition)) &&
            (identical(other.pickedFieldPiece, pickedFieldPiece) ||
                const DeepCollectionEquality()
                    .equals(other.pickedFieldPiece, pickedFieldPiece)) &&
            (identical(other.pickedHoldingPiece, pickedHoldingPiece) ||
                const DeepCollectionEquality()
                    .equals(other.pickedHoldingPiece, pickedHoldingPiece)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(roomID) ^
      const DeepCollectionEquality().hash(battleState) ^
      const DeepCollectionEquality().hash(player) ^
      const DeepCollectionEquality().hash(playerAID) ^
      const DeepCollectionEquality().hash(playerBID) ^
      const DeepCollectionEquality().hash(holding) ^
      const DeepCollectionEquality().hash(field) ^
      const DeepCollectionEquality().hash(winLine) ^
      const DeepCollectionEquality().hash(operable) ^
      const DeepCollectionEquality().hash(pickedPosition) ^
      const DeepCollectionEquality().hash(pickedFieldPiece) ^
      const DeepCollectionEquality().hash(pickedHoldingPiece);

  @JsonKey(ignore: true)
  @override
  _$BattleControllerStateCopyWith<_BattleControllerState> get copyWith =>
      __$BattleControllerStateCopyWithImpl<_BattleControllerState>(
          this, _$identity);
}

abstract class _BattleControllerState implements BattleControllerState {
  const factory _BattleControllerState(
      {required String roomID,
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
      required Piece pickedHoldingPiece}) = _$_BattleControllerState;

  @override
  String get roomID => throw _privateConstructorUsedError;
  @override
  BattleState get battleState => throw _privateConstructorUsedError;
  @override
  Player get player => throw _privateConstructorUsedError;
  @override
  String get playerAID => throw _privateConstructorUsedError;
  @override
  String get playerBID => throw _privateConstructorUsedError;
  @override
  Holding get holding => throw _privateConstructorUsedError;
  @override
  List<PieceStack> get field => throw _privateConstructorUsedError;
  @override
  WinLine get winLine => throw _privateConstructorUsedError;
  @override
  bool get operable => throw _privateConstructorUsedError;
  @override
  Position get pickedPosition => throw _privateConstructorUsedError;
  @override
  Piece get pickedFieldPiece => throw _privateConstructorUsedError;
  @override
  Piece get pickedHoldingPiece => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BattleControllerStateCopyWith<_BattleControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}
