// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_level_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryLevelDto {

 String get id; String get label; int get columns; List<String> get symbols;
/// Create a copy of MemoryLevelDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryLevelDtoCopyWith<MemoryLevelDto> get copyWith => _$MemoryLevelDtoCopyWithImpl<MemoryLevelDto>(this as MemoryLevelDto, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemoryLevelDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryLevelDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.columns, _this.columns) || other.columns == _this.columns)&&const DeepCollectionEquality().equals(other.symbols, _this.symbols));
}


@override
int get hashCode {
  final _this = this as MemoryLevelDto;
  return Object.hash(runtimeType,_this.id,_this.label,_this.columns,const DeepCollectionEquality().hash(_this.symbols));
}

@override
String toString() {
  final _this = this as MemoryLevelDto;
  return 'MemoryLevelDto(id: ${_this.id}, label: ${_this.label}, columns: ${_this.columns}, symbols: ${_this.symbols})';
}


}

/// @nodoc
abstract mixin class $MemoryLevelDtoCopyWith<$Res>  {
  factory $MemoryLevelDtoCopyWith(MemoryLevelDto value, $Res Function(MemoryLevelDto) _then) = _$MemoryLevelDtoCopyWithImpl;
@useResult
$Res call({
 String id, String label, int columns, List<String> symbols
});




}
/// @nodoc
class _$MemoryLevelDtoCopyWithImpl<$Res>
    implements $MemoryLevelDtoCopyWith<$Res> {
  _$MemoryLevelDtoCopyWithImpl(this._self, this._then);

  final MemoryLevelDto _self;
  final $Res Function(MemoryLevelDto) _then;

/// Create a copy of MemoryLevelDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? columns = null,Object? symbols = null,}) {
  return _then(MemoryLevelDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as int,symbols: null == symbols ? _self.symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryLevelDto].
extension MemoryLevelDtoPatterns on MemoryLevelDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryLevelDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryLevelDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryLevelDto value)  $default,){
final _that = this;
switch (_that) {
case _MemoryLevelDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryLevelDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryLevelDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  int columns,  List<String> symbols)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryLevelDto() when $default != null:
return $default(_that.id,_that.label,_that.columns,_that.symbols);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  int columns,  List<String> symbols)  $default,) {final _that = this;
switch (_that) {
case _MemoryLevelDto():
return $default(_that.id,_that.label,_that.columns,_that.symbols);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  int columns,  List<String> symbols)?  $default,) {final _that = this;
switch (_that) {
case _MemoryLevelDto() when $default != null:
return $default(_that.id,_that.label,_that.columns,_that.symbols);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryLevelDto extends MemoryLevelDto {
  const _MemoryLevelDto({required this.id, required this.label, required this.columns, required  List<String> symbols}): _symbols = symbols,super._();
  

@override final  String id;
@override final  String label;
@override final  int columns;
 final  List<String> _symbols;
@override List<String> get symbols {
  if (_symbols is EqualUnmodifiableListView) return _symbols;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symbols);
}


/// Create a copy of MemoryLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryLevelDtoCopyWith<_MemoryLevelDto> get copyWith => __$MemoryLevelDtoCopyWithImpl<_MemoryLevelDto>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryLevelDto&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.columns, columns) || other.columns == columns)&&const DeepCollectionEquality().equals(other.symbols, _symbols));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,label,columns,const DeepCollectionEquality().hash(_symbols));
}

@override
String toString() {
    return 'MemoryLevelDto(id: $id, label: $label, columns: $columns, symbols: $symbols)';
}


}

/// @nodoc
abstract mixin class _$MemoryLevelDtoCopyWith<$Res> implements $MemoryLevelDtoCopyWith<$Res> {
  factory _$MemoryLevelDtoCopyWith(_MemoryLevelDto value, $Res Function(_MemoryLevelDto) _then) = __$MemoryLevelDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int columns, List<String> symbols
});




}
/// @nodoc
class __$MemoryLevelDtoCopyWithImpl<$Res>
    implements _$MemoryLevelDtoCopyWith<$Res> {
  __$MemoryLevelDtoCopyWithImpl(this._self, this._then);

  final _MemoryLevelDto _self;
  final $Res Function(_MemoryLevelDto) _then;

/// Create a copy of MemoryLevelDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? columns = null,Object? symbols = null,}) {
  return _then(_MemoryLevelDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as int,symbols: null == symbols ? _self._symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
