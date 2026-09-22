// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_level_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemoryLevelEntity {

 String get id;/// Libelle du niveau, affiche au joueur.
 String get label;/// Nombre de colonnes de la grille.
 int get columns;/// Symboles utilises : un symbole == une paire.
 List<String> get symbols;
/// Create a copy of MemoryLevelEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryLevelEntityCopyWith<MemoryLevelEntity> get copyWith => _$MemoryLevelEntityCopyWithImpl<MemoryLevelEntity>(this as MemoryLevelEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemoryLevelEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryLevelEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.columns, _this.columns) || other.columns == _this.columns)&&const DeepCollectionEquality().equals(other.symbols, _this.symbols));
}


@override
int get hashCode {
  final _this = this as MemoryLevelEntity;
  return Object.hash(runtimeType,_this.id,_this.label,_this.columns,const DeepCollectionEquality().hash(_this.symbols));
}

@override
String toString() {
  final _this = this as MemoryLevelEntity;
  return 'MemoryLevelEntity(id: ${_this.id}, label: ${_this.label}, columns: ${_this.columns}, symbols: ${_this.symbols})';
}


}

/// @nodoc
abstract mixin class $MemoryLevelEntityCopyWith<$Res>  {
  factory $MemoryLevelEntityCopyWith(MemoryLevelEntity value, $Res Function(MemoryLevelEntity) _then) = _$MemoryLevelEntityCopyWithImpl;
@useResult
$Res call({
 String id, String label, int columns, List<String> symbols
});




}
/// @nodoc
class _$MemoryLevelEntityCopyWithImpl<$Res>
    implements $MemoryLevelEntityCopyWith<$Res> {
  _$MemoryLevelEntityCopyWithImpl(this._self, this._then);

  final MemoryLevelEntity _self;
  final $Res Function(MemoryLevelEntity) _then;

/// Create a copy of MemoryLevelEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? columns = null,Object? symbols = null,}) {
  return _then(MemoryLevelEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as int,symbols: null == symbols ? _self.symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryLevelEntity].
extension MemoryLevelEntityPatterns on MemoryLevelEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryLevelEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryLevelEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryLevelEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoryLevelEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryLevelEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryLevelEntity() when $default != null:
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
case _MemoryLevelEntity() when $default != null:
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
case _MemoryLevelEntity():
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
case _MemoryLevelEntity() when $default != null:
return $default(_that.id,_that.label,_that.columns,_that.symbols);case _:
  return null;

}
}

}

/// @nodoc


class _MemoryLevelEntity extends MemoryLevelEntity {
  const _MemoryLevelEntity({required this.id, required this.label, required this.columns, required  List<String> symbols}): _symbols = symbols,super._();
  

@override final  String id;
/// Libelle du niveau, affiche au joueur.
@override final  String label;
/// Nombre de colonnes de la grille.
@override final  int columns;
/// Symboles utilises : un symbole == une paire.
 final  List<String> _symbols;
/// Symboles utilises : un symbole == une paire.
@override List<String> get symbols {
  if (_symbols is EqualUnmodifiableListView) return _symbols;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_symbols);
}


/// Create a copy of MemoryLevelEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryLevelEntityCopyWith<_MemoryLevelEntity> get copyWith => __$MemoryLevelEntityCopyWithImpl<_MemoryLevelEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryLevelEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.columns, columns) || other.columns == columns)&&const DeepCollectionEquality().equals(other.symbols, _symbols));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,label,columns,const DeepCollectionEquality().hash(_symbols));
}

@override
String toString() {
    return 'MemoryLevelEntity(id: $id, label: $label, columns: $columns, symbols: $symbols)';
}


}

/// @nodoc
abstract mixin class _$MemoryLevelEntityCopyWith<$Res> implements $MemoryLevelEntityCopyWith<$Res> {
  factory _$MemoryLevelEntityCopyWith(_MemoryLevelEntity value, $Res Function(_MemoryLevelEntity) _then) = __$MemoryLevelEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int columns, List<String> symbols
});




}
/// @nodoc
class __$MemoryLevelEntityCopyWithImpl<$Res>
    implements _$MemoryLevelEntityCopyWith<$Res> {
  __$MemoryLevelEntityCopyWithImpl(this._self, this._then);

  final _MemoryLevelEntity _self;
  final $Res Function(_MemoryLevelEntity) _then;

/// Create a copy of MemoryLevelEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? columns = null,Object? symbols = null,}) {
  return _then(_MemoryLevelEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,columns: null == columns ? _self.columns : columns // ignore: cast_nullable_to_non_nullable
as int,symbols: null == symbols ? _self._symbols : symbols // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
