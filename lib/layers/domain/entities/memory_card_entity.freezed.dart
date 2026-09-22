// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryCardEntity {

 int get id; String get symbol;/// La carte est retournee mais pas encore validee.
 bool get isFaceUp;/// La paire a ete trouvee : la carte reste visible jusqu'a la fin.
 bool get isMatched;
/// Create a copy of MemoryCardEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryCardEntityCopyWith<MemoryCardEntity> get copyWith => _$MemoryCardEntityCopyWithImpl<MemoryCardEntity>(this as MemoryCardEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemoryCardEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryCardEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.isFaceUp, _this.isFaceUp) || other.isFaceUp == _this.isFaceUp)&&(identical(other.isMatched, _this.isMatched) || other.isMatched == _this.isMatched));
}


@override
int get hashCode {
  final _this = this as MemoryCardEntity;
  return Object.hash(runtimeType,_this.id,_this.symbol,_this.isFaceUp,_this.isMatched);
}

@override
String toString() {
  final _this = this as MemoryCardEntity;
  return 'MemoryCardEntity(id: ${_this.id}, symbol: ${_this.symbol}, isFaceUp: ${_this.isFaceUp}, isMatched: ${_this.isMatched})';
}


}

/// @nodoc
abstract mixin class $MemoryCardEntityCopyWith<$Res>  {
  factory $MemoryCardEntityCopyWith(MemoryCardEntity value, $Res Function(MemoryCardEntity) _then) = _$MemoryCardEntityCopyWithImpl;
@useResult
$Res call({
 int id, String symbol, bool isFaceUp, bool isMatched
});




}
/// @nodoc
class _$MemoryCardEntityCopyWithImpl<$Res>
    implements $MemoryCardEntityCopyWith<$Res> {
  _$MemoryCardEntityCopyWithImpl(this._self, this._then);

  final MemoryCardEntity _self;
  final $Res Function(MemoryCardEntity) _then;

/// Create a copy of MemoryCardEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? symbol = null,Object? isFaceUp = null,Object? isMatched = null,}) {
  return _then(MemoryCardEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,isFaceUp: null == isFaceUp ? _self.isFaceUp : isFaceUp // ignore: cast_nullable_to_non_nullable
as bool,isMatched: null == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryCardEntity].
extension MemoryCardEntityPatterns on MemoryCardEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryCardEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryCardEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryCardEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoryCardEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryCardEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryCardEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String symbol,  bool isFaceUp,  bool isMatched)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryCardEntity() when $default != null:
return $default(_that.id,_that.symbol,_that.isFaceUp,_that.isMatched);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String symbol,  bool isFaceUp,  bool isMatched)  $default,) {final _that = this;
switch (_that) {
case _MemoryCardEntity():
return $default(_that.id,_that.symbol,_that.isFaceUp,_that.isMatched);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String symbol,  bool isFaceUp,  bool isMatched)?  $default,) {final _that = this;
switch (_that) {
case _MemoryCardEntity() when $default != null:
return $default(_that.id,_that.symbol,_that.isFaceUp,_that.isMatched);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryCardEntity extends MemoryCardEntity {
  const _MemoryCardEntity({required this.id, required this.symbol, this.isFaceUp = false, this.isMatched = false}): super._();
  

@override final  int id;
@override final  String symbol;
/// La carte est retournee mais pas encore validee.
@override@JsonKey() final  bool isFaceUp;
/// La paire a ete trouvee : la carte reste visible jusqu'a la fin.
@override@JsonKey() final  bool isMatched;

/// Create a copy of MemoryCardEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryCardEntityCopyWith<_MemoryCardEntity> get copyWith => __$MemoryCardEntityCopyWithImpl<_MemoryCardEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryCardEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.isFaceUp, isFaceUp) || other.isFaceUp == isFaceUp)&&(identical(other.isMatched, isMatched) || other.isMatched == isMatched));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,symbol,isFaceUp,isMatched);
}

@override
String toString() {
    return 'MemoryCardEntity(id: $id, symbol: $symbol, isFaceUp: $isFaceUp, isMatched: $isMatched)';
}


}

/// @nodoc
abstract mixin class _$MemoryCardEntityCopyWith<$Res> implements $MemoryCardEntityCopyWith<$Res> {
  factory _$MemoryCardEntityCopyWith(_MemoryCardEntity value, $Res Function(_MemoryCardEntity) _then) = __$MemoryCardEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String symbol, bool isFaceUp, bool isMatched
});




}
/// @nodoc
class __$MemoryCardEntityCopyWithImpl<$Res>
    implements _$MemoryCardEntityCopyWith<$Res> {
  __$MemoryCardEntityCopyWithImpl(this._self, this._then);

  final _MemoryCardEntity _self;
  final $Res Function(_MemoryCardEntity) _then;

/// Create a copy of MemoryCardEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? symbol = null,Object? isFaceUp = null,Object? isMatched = null,}) {
  return _then(_MemoryCardEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,isFaceUp: null == isFaceUp ? _self.isFaceUp : isFaceUp // ignore: cast_nullable_to_non_nullable
as bool,isMatched: null == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
