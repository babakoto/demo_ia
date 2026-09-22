// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_board_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryBoardEntity {

/// Les cartes, dans l'ordre d'affichage de la grille.
 List<MemoryCardEntity> get cards;/// Nombre de coups joues (un coup == deux cartes retournees).
 int get moves;/// Index de la premiere carte retournee du coup en cours.
 int? get firstPick;/// Index de la seconde carte, renseigne uniquement sur une paire ratee.
 int? get secondPick;
/// Create a copy of MemoryBoardEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryBoardEntityCopyWith<MemoryBoardEntity> get copyWith => _$MemoryBoardEntityCopyWithImpl<MemoryBoardEntity>(this as MemoryBoardEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemoryBoardEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryBoardEntity&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.moves, _this.moves) || other.moves == _this.moves)&&(identical(other.firstPick, _this.firstPick) || other.firstPick == _this.firstPick)&&(identical(other.secondPick, _this.secondPick) || other.secondPick == _this.secondPick));
}


@override
int get hashCode {
  final _this = this as MemoryBoardEntity;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.cards),_this.moves,_this.firstPick,_this.secondPick);
}

@override
String toString() {
  final _this = this as MemoryBoardEntity;
  return 'MemoryBoardEntity(cards: ${_this.cards}, moves: ${_this.moves}, firstPick: ${_this.firstPick}, secondPick: ${_this.secondPick})';
}


}

/// @nodoc
abstract mixin class $MemoryBoardEntityCopyWith<$Res>  {
  factory $MemoryBoardEntityCopyWith(MemoryBoardEntity value, $Res Function(MemoryBoardEntity) _then) = _$MemoryBoardEntityCopyWithImpl;
@useResult
$Res call({
 List<MemoryCardEntity> cards, int moves, int? firstPick, int? secondPick
});




}
/// @nodoc
class _$MemoryBoardEntityCopyWithImpl<$Res>
    implements $MemoryBoardEntityCopyWith<$Res> {
  _$MemoryBoardEntityCopyWithImpl(this._self, this._then);

  final MemoryBoardEntity _self;
  final $Res Function(MemoryBoardEntity) _then;

/// Create a copy of MemoryBoardEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cards = null,Object? moves = null,Object? firstPick = freezed,Object? secondPick = freezed,}) {
  return _then(MemoryBoardEntity(
cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<MemoryCardEntity>,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,firstPick: freezed == firstPick ? _self.firstPick : firstPick // ignore: cast_nullable_to_non_nullable
as int?,secondPick: freezed == secondPick ? _self.secondPick : secondPick // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryBoardEntity].
extension MemoryBoardEntityPatterns on MemoryBoardEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryBoardEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryBoardEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryBoardEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoryBoardEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryBoardEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryBoardEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MemoryCardEntity> cards,  int moves,  int? firstPick,  int? secondPick)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryBoardEntity() when $default != null:
return $default(_that.cards,_that.moves,_that.firstPick,_that.secondPick);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MemoryCardEntity> cards,  int moves,  int? firstPick,  int? secondPick)  $default,) {final _that = this;
switch (_that) {
case _MemoryBoardEntity():
return $default(_that.cards,_that.moves,_that.firstPick,_that.secondPick);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MemoryCardEntity> cards,  int moves,  int? firstPick,  int? secondPick)?  $default,) {final _that = this;
switch (_that) {
case _MemoryBoardEntity() when $default != null:
return $default(_that.cards,_that.moves,_that.firstPick,_that.secondPick);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryBoardEntity extends MemoryBoardEntity {
  const _MemoryBoardEntity({ List<MemoryCardEntity> cards = const <MemoryCardEntity>[], this.moves = 0, this.firstPick, this.secondPick}): _cards = cards,super._();
  

/// Les cartes, dans l'ordre d'affichage de la grille.
 final  List<MemoryCardEntity> _cards;
/// Les cartes, dans l'ordre d'affichage de la grille.
@override@JsonKey() List<MemoryCardEntity> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

/// Nombre de coups joues (un coup == deux cartes retournees).
@override@JsonKey() final  int moves;
/// Index de la premiere carte retournee du coup en cours.
@override final  int? firstPick;
/// Index de la seconde carte, renseigne uniquement sur une paire ratee.
@override final  int? secondPick;

/// Create a copy of MemoryBoardEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryBoardEntityCopyWith<_MemoryBoardEntity> get copyWith => __$MemoryBoardEntityCopyWithImpl<_MemoryBoardEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryBoardEntity&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.moves, moves) || other.moves == moves)&&(identical(other.firstPick, firstPick) || other.firstPick == firstPick)&&(identical(other.secondPick, secondPick) || other.secondPick == secondPick));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards),moves,firstPick,secondPick);
}

@override
String toString() {
    return 'MemoryBoardEntity(cards: $cards, moves: $moves, firstPick: $firstPick, secondPick: $secondPick)';
}


}

/// @nodoc
abstract mixin class _$MemoryBoardEntityCopyWith<$Res> implements $MemoryBoardEntityCopyWith<$Res> {
  factory _$MemoryBoardEntityCopyWith(_MemoryBoardEntity value, $Res Function(_MemoryBoardEntity) _then) = __$MemoryBoardEntityCopyWithImpl;
@override @useResult
$Res call({
 List<MemoryCardEntity> cards, int moves, int? firstPick, int? secondPick
});




}
/// @nodoc
class __$MemoryBoardEntityCopyWithImpl<$Res>
    implements _$MemoryBoardEntityCopyWith<$Res> {
  __$MemoryBoardEntityCopyWithImpl(this._self, this._then);

  final _MemoryBoardEntity _self;
  final $Res Function(_MemoryBoardEntity) _then;

/// Create a copy of MemoryBoardEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cards = null,Object? moves = null,Object? firstPick = freezed,Object? secondPick = freezed,}) {
  return _then(_MemoryBoardEntity(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<MemoryCardEntity>,moves: null == moves ? _self.moves : moves // ignore: cast_nullable_to_non_nullable
as int,firstPick: freezed == firstPick ? _self.firstPick : firstPick // ignore: cast_nullable_to_non_nullable
as int?,secondPick: freezed == secondPick ? _self.secondPick : secondPick // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
