// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_bus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveBus {

 String get id; String get routeId; String get lastKnownStop; String get direction;
/// Create a copy of LiveBus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveBusCopyWith<LiveBus> get copyWith => _$LiveBusCopyWithImpl<LiveBus>(this as LiveBus, _$identity);

  /// Serializes this LiveBus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveBus&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.lastKnownStop, lastKnownStop) || other.lastKnownStop == lastKnownStop)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,lastKnownStop,direction);

@override
String toString() {
  return 'LiveBus(id: $id, routeId: $routeId, lastKnownStop: $lastKnownStop, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $LiveBusCopyWith<$Res>  {
  factory $LiveBusCopyWith(LiveBus value, $Res Function(LiveBus) _then) = _$LiveBusCopyWithImpl;
@useResult
$Res call({
 String id, String routeId, String lastKnownStop, String direction
});




}
/// @nodoc
class _$LiveBusCopyWithImpl<$Res>
    implements $LiveBusCopyWith<$Res> {
  _$LiveBusCopyWithImpl(this._self, this._then);

  final LiveBus _self;
  final $Res Function(LiveBus) _then;

/// Create a copy of LiveBus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routeId = null,Object? lastKnownStop = null,Object? direction = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,lastKnownStop: null == lastKnownStop ? _self.lastKnownStop : lastKnownStop // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveBus].
extension LiveBusPatterns on LiveBus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveBus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveBus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveBus value)  $default,){
final _that = this;
switch (_that) {
case _LiveBus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveBus value)?  $default,){
final _that = this;
switch (_that) {
case _LiveBus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String routeId,  String lastKnownStop,  String direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveBus() when $default != null:
return $default(_that.id,_that.routeId,_that.lastKnownStop,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String routeId,  String lastKnownStop,  String direction)  $default,) {final _that = this;
switch (_that) {
case _LiveBus():
return $default(_that.id,_that.routeId,_that.lastKnownStop,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String routeId,  String lastKnownStop,  String direction)?  $default,) {final _that = this;
switch (_that) {
case _LiveBus() when $default != null:
return $default(_that.id,_that.routeId,_that.lastKnownStop,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveBus implements LiveBus {
  const _LiveBus({required this.id, required this.routeId, required this.lastKnownStop, required this.direction});
  factory _LiveBus.fromJson(Map<String, dynamic> json) => _$LiveBusFromJson(json);

@override final  String id;
@override final  String routeId;
@override final  String lastKnownStop;
@override final  String direction;

/// Create a copy of LiveBus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveBusCopyWith<_LiveBus> get copyWith => __$LiveBusCopyWithImpl<_LiveBus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveBusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveBus&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.lastKnownStop, lastKnownStop) || other.lastKnownStop == lastKnownStop)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,lastKnownStop,direction);

@override
String toString() {
  return 'LiveBus(id: $id, routeId: $routeId, lastKnownStop: $lastKnownStop, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$LiveBusCopyWith<$Res> implements $LiveBusCopyWith<$Res> {
  factory _$LiveBusCopyWith(_LiveBus value, $Res Function(_LiveBus) _then) = __$LiveBusCopyWithImpl;
@override @useResult
$Res call({
 String id, String routeId, String lastKnownStop, String direction
});




}
/// @nodoc
class __$LiveBusCopyWithImpl<$Res>
    implements _$LiveBusCopyWith<$Res> {
  __$LiveBusCopyWithImpl(this._self, this._then);

  final _LiveBus _self;
  final $Res Function(_LiveBus) _then;

/// Create a copy of LiveBus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routeId = null,Object? lastKnownStop = null,Object? direction = null,}) {
  return _then(_LiveBus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,lastKnownStop: null == lastKnownStop ? _self.lastKnownStop : lastKnownStop // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
