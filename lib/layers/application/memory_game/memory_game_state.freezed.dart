// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryGameState {

 BlocStatus get status; MemoryBoardEntity get board; MemoryLevelEntity? get level;/// Vrai tant que la paire ratee est affichee : les taps sont ignores.
 bool get isLocked;/// Numero de la manche en cours.
///
/// Incremente a chaque distribution, il permet a un retournement differe de
/// savoir que son plateau n'existe plus (redistribution pendant l'attente).
 int get round; Failure? get failure;
/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryGameStateCopyWith<MemoryGameState> get copyWith => _$MemoryGameStateCopyWithImpl<MemoryGameState>(this as MemoryGameState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemoryGameState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryGameState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.board, _this.board) || other.board == _this.board)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.isLocked, _this.isLocked) || other.isLocked == _this.isLocked)&&(identical(other.round, _this.round) || other.round == _this.round)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as MemoryGameState;
  return Object.hash(runtimeType,_this.status,_this.board,_this.level,_this.isLocked,_this.round,_this.failure);
}

@override
String toString() {
  final _this = this as MemoryGameState;
  return 'MemoryGameState(status: ${_this.status}, board: ${_this.board}, level: ${_this.level}, isLocked: ${_this.isLocked}, round: ${_this.round}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $MemoryGameStateCopyWith<$Res>  {
  factory $MemoryGameStateCopyWith(MemoryGameState value, $Res Function(MemoryGameState) _then) = _$MemoryGameStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus status, MemoryBoardEntity board, MemoryLevelEntity? level, bool isLocked, int round, Failure? failure
});


$MemoryBoardEntityCopyWith<$Res> get board;$MemoryLevelEntityCopyWith<$Res>? get level;

}
/// @nodoc
class _$MemoryGameStateCopyWithImpl<$Res>
    implements $MemoryGameStateCopyWith<$Res> {
  _$MemoryGameStateCopyWithImpl(this._self, this._then);

  final MemoryGameState _self;
  final $Res Function(MemoryGameState) _then;

/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? board = null,Object? level = freezed,Object? isLocked = null,Object? round = null,Object? failure = freezed,}) {
  return _then(MemoryGameState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as MemoryBoardEntity,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as MemoryLevelEntity?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryBoardEntityCopyWith<$Res> get board {
  
  return $MemoryBoardEntityCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryLevelEntityCopyWith<$Res>? get level {
    if (_self.level == null) {
    return null;
  }

  return $MemoryLevelEntityCopyWith<$Res>(_self.level!, (value) {
    return _then(_self.copyWith(level: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemoryGameState].
extension MemoryGameStatePatterns on MemoryGameState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryGameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryGameState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryGameState value)  $default,){
final _that = this;
switch (_that) {
case _MemoryGameState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryGameState value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryGameState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus status,  MemoryBoardEntity board,  MemoryLevelEntity? level,  bool isLocked,  int round,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryGameState() when $default != null:
return $default(_that.status,_that.board,_that.level,_that.isLocked,_that.round,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus status,  MemoryBoardEntity board,  MemoryLevelEntity? level,  bool isLocked,  int round,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _MemoryGameState():
return $default(_that.status,_that.board,_that.level,_that.isLocked,_that.round,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus status,  MemoryBoardEntity board,  MemoryLevelEntity? level,  bool isLocked,  int round,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MemoryGameState() when $default != null:
return $default(_that.status,_that.board,_that.level,_that.isLocked,_that.round,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryGameState extends MemoryGameState {
  const _MemoryGameState({this.status = BlocStatus.initial, this.board = const MemoryBoardEntity(), this.level, this.isLocked = false, this.round = 0, this.failure}): super._();
  

@override@JsonKey() final  BlocStatus status;
@override@JsonKey() final  MemoryBoardEntity board;
@override final  MemoryLevelEntity? level;
/// Vrai tant que la paire ratee est affichee : les taps sont ignores.
@override@JsonKey() final  bool isLocked;
/// Numero de la manche en cours.
///
/// Incremente a chaque distribution, il permet a un retournement differe de
/// savoir que son plateau n'existe plus (redistribution pendant l'attente).
@override@JsonKey() final  int round;
@override final  Failure? failure;

/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryGameStateCopyWith<_MemoryGameState> get copyWith => __$MemoryGameStateCopyWithImpl<_MemoryGameState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryGameState&&(identical(other.status, status) || other.status == status)&&(identical(other.board, board) || other.board == board)&&(identical(other.level, level) || other.level == level)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.round, round) || other.round == round)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,board,level,isLocked,round,failure);
}

@override
String toString() {
    return 'MemoryGameState(status: $status, board: $board, level: $level, isLocked: $isLocked, round: $round, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MemoryGameStateCopyWith<$Res> implements $MemoryGameStateCopyWith<$Res> {
  factory _$MemoryGameStateCopyWith(_MemoryGameState value, $Res Function(_MemoryGameState) _then) = __$MemoryGameStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus status, MemoryBoardEntity board, MemoryLevelEntity? level, bool isLocked, int round, Failure? failure
});


@override $MemoryBoardEntityCopyWith<$Res> get board;@override $MemoryLevelEntityCopyWith<$Res>? get level;

}
/// @nodoc
class __$MemoryGameStateCopyWithImpl<$Res>
    implements _$MemoryGameStateCopyWith<$Res> {
  __$MemoryGameStateCopyWithImpl(this._self, this._then);

  final _MemoryGameState _self;
  final $Res Function(_MemoryGameState) _then;

/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? board = null,Object? level = freezed,Object? isLocked = null,Object? round = null,Object? failure = freezed,}) {
  return _then(_MemoryGameState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as MemoryBoardEntity,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as MemoryLevelEntity?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryBoardEntityCopyWith<$Res> get board {
  
  return $MemoryBoardEntityCopyWith<$Res>(_self.board, (value) {
    return _then(_self.copyWith(board: value));
  });
}/// Create a copy of MemoryGameState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryLevelEntityCopyWith<$Res>? get level {
    if (_self.level == null) {
    return null;
  }

  return $MemoryLevelEntityCopyWith<$Res>(_self.level!, (value) {
    return _then(_self.copyWith(level: value));
  });
}
}

// dart format on
