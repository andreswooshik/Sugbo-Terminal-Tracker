// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusRoute {

 String get id; String get name;// "IT Park ↔ Il Corso"
 Operator get operator; String get fare;// "FREE" or "₱30"
 String get scheduleSummary;// "Daily", "Weekdays every 30 min", etc.
 List<String> get southboundStops; List<String> get northboundStops;
/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusRouteCopyWith<BusRoute> get copyWith => _$BusRouteCopyWithImpl<BusRoute>(this as BusRoute, _$identity);

  /// Serializes this BusRoute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusRoute&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.fare, fare) || other.fare == fare)&&(identical(other.scheduleSummary, scheduleSummary) || other.scheduleSummary == scheduleSummary)&&const DeepCollectionEquality().equals(other.southboundStops, southboundStops)&&const DeepCollectionEquality().equals(other.northboundStops, northboundStops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,operator,fare,scheduleSummary,const DeepCollectionEquality().hash(southboundStops),const DeepCollectionEquality().hash(northboundStops));

@override
String toString() {
  return 'BusRoute(id: $id, name: $name, operator: $operator, fare: $fare, scheduleSummary: $scheduleSummary, southboundStops: $southboundStops, northboundStops: $northboundStops)';
}


}

/// @nodoc
abstract mixin class $BusRouteCopyWith<$Res>  {
  factory $BusRouteCopyWith(BusRoute value, $Res Function(BusRoute) _then) = _$BusRouteCopyWithImpl;
@useResult
$Res call({
 String id, String name, Operator operator, String fare, String scheduleSummary, List<String> southboundStops, List<String> northboundStops
});




}
/// @nodoc
class _$BusRouteCopyWithImpl<$Res>
    implements $BusRouteCopyWith<$Res> {
  _$BusRouteCopyWithImpl(this._self, this._then);

  final BusRoute _self;
  final $Res Function(BusRoute) _then;

/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? operator = null,Object? fare = null,Object? scheduleSummary = null,Object? southboundStops = null,Object? northboundStops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as Operator,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as String,scheduleSummary: null == scheduleSummary ? _self.scheduleSummary : scheduleSummary // ignore: cast_nullable_to_non_nullable
as String,southboundStops: null == southboundStops ? _self.southboundStops : southboundStops // ignore: cast_nullable_to_non_nullable
as List<String>,northboundStops: null == northboundStops ? _self.northboundStops : northboundStops // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BusRoute].
extension BusRoutePatterns on BusRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusRoute value)  $default,){
final _that = this;
switch (_that) {
case _BusRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusRoute value)?  $default,){
final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Operator operator,  String fare,  String scheduleSummary,  List<String> southboundStops,  List<String> northboundStops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
return $default(_that.id,_that.name,_that.operator,_that.fare,_that.scheduleSummary,_that.southboundStops,_that.northboundStops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Operator operator,  String fare,  String scheduleSummary,  List<String> southboundStops,  List<String> northboundStops)  $default,) {final _that = this;
switch (_that) {
case _BusRoute():
return $default(_that.id,_that.name,_that.operator,_that.fare,_that.scheduleSummary,_that.southboundStops,_that.northboundStops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Operator operator,  String fare,  String scheduleSummary,  List<String> southboundStops,  List<String> northboundStops)?  $default,) {final _that = this;
switch (_that) {
case _BusRoute() when $default != null:
return $default(_that.id,_that.name,_that.operator,_that.fare,_that.scheduleSummary,_that.southboundStops,_that.northboundStops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusRoute implements BusRoute {
  const _BusRoute({required this.id, required this.name, required this.operator, required this.fare, required this.scheduleSummary, required final  List<String> southboundStops, required final  List<String> northboundStops}): _southboundStops = southboundStops,_northboundStops = northboundStops;
  factory _BusRoute.fromJson(Map<String, dynamic> json) => _$BusRouteFromJson(json);

@override final  String id;
@override final  String name;
// "IT Park ↔ Il Corso"
@override final  Operator operator;
@override final  String fare;
// "FREE" or "₱30"
@override final  String scheduleSummary;
// "Daily", "Weekdays every 30 min", etc.
 final  List<String> _southboundStops;
// "Daily", "Weekdays every 30 min", etc.
@override List<String> get southboundStops {
  if (_southboundStops is EqualUnmodifiableListView) return _southboundStops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_southboundStops);
}

 final  List<String> _northboundStops;
@override List<String> get northboundStops {
  if (_northboundStops is EqualUnmodifiableListView) return _northboundStops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_northboundStops);
}


/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusRouteCopyWith<_BusRoute> get copyWith => __$BusRouteCopyWithImpl<_BusRoute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusRouteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusRoute&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.fare, fare) || other.fare == fare)&&(identical(other.scheduleSummary, scheduleSummary) || other.scheduleSummary == scheduleSummary)&&const DeepCollectionEquality().equals(other._southboundStops, _southboundStops)&&const DeepCollectionEquality().equals(other._northboundStops, _northboundStops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,operator,fare,scheduleSummary,const DeepCollectionEquality().hash(_southboundStops),const DeepCollectionEquality().hash(_northboundStops));

@override
String toString() {
  return 'BusRoute(id: $id, name: $name, operator: $operator, fare: $fare, scheduleSummary: $scheduleSummary, southboundStops: $southboundStops, northboundStops: $northboundStops)';
}


}

/// @nodoc
abstract mixin class _$BusRouteCopyWith<$Res> implements $BusRouteCopyWith<$Res> {
  factory _$BusRouteCopyWith(_BusRoute value, $Res Function(_BusRoute) _then) = __$BusRouteCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Operator operator, String fare, String scheduleSummary, List<String> southboundStops, List<String> northboundStops
});




}
/// @nodoc
class __$BusRouteCopyWithImpl<$Res>
    implements _$BusRouteCopyWith<$Res> {
  __$BusRouteCopyWithImpl(this._self, this._then);

  final _BusRoute _self;
  final $Res Function(_BusRoute) _then;

/// Create a copy of BusRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? operator = null,Object? fare = null,Object? scheduleSummary = null,Object? southboundStops = null,Object? northboundStops = null,}) {
  return _then(_BusRoute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as Operator,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as String,scheduleSummary: null == scheduleSummary ? _self.scheduleSummary : scheduleSummary // ignore: cast_nullable_to_non_nullable
as String,southboundStops: null == southboundStops ? _self._southboundStops : southboundStops // ignore: cast_nullable_to_non_nullable
as List<String>,northboundStops: null == northboundStops ? _self._northboundStops : northboundStops // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
