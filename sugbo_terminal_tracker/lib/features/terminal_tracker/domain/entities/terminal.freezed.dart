// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terminal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Terminal {

 String get id; String get name; String? get operator;// e.g., "BRT anchor", "MyBus main hub"
@JsonKey(name: 'wait_time') int? get waitTime;// in minutes
@JsonKey(name: 'last_updated') DateTime? get lastUpdated;@JsonKey(name: 'routes_available') int? get routesAvailable;
/// Create a copy of Terminal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TerminalCopyWith<Terminal> get copyWith => _$TerminalCopyWithImpl<Terminal>(this as Terminal, _$identity);

  /// Serializes this Terminal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Terminal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.waitTime, waitTime) || other.waitTime == waitTime)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.routesAvailable, routesAvailable) || other.routesAvailable == routesAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,operator,waitTime,lastUpdated,routesAvailable);

@override
String toString() {
  return 'Terminal(id: $id, name: $name, operator: $operator, waitTime: $waitTime, lastUpdated: $lastUpdated, routesAvailable: $routesAvailable)';
}


}

/// @nodoc
abstract mixin class $TerminalCopyWith<$Res>  {
  factory $TerminalCopyWith(Terminal value, $Res Function(Terminal) _then) = _$TerminalCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? operator,@JsonKey(name: 'wait_time') int? waitTime,@JsonKey(name: 'last_updated') DateTime? lastUpdated,@JsonKey(name: 'routes_available') int? routesAvailable
});




}
/// @nodoc
class _$TerminalCopyWithImpl<$Res>
    implements $TerminalCopyWith<$Res> {
  _$TerminalCopyWithImpl(this._self, this._then);

  final Terminal _self;
  final $Res Function(Terminal) _then;

/// Create a copy of Terminal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? operator = freezed,Object? waitTime = freezed,Object? lastUpdated = freezed,Object? routesAvailable = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,operator: freezed == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String?,waitTime: freezed == waitTime ? _self.waitTime : waitTime // ignore: cast_nullable_to_non_nullable
as int?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,routesAvailable: freezed == routesAvailable ? _self.routesAvailable : routesAvailable // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Terminal].
extension TerminalPatterns on Terminal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Terminal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Terminal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Terminal value)  $default,){
final _that = this;
switch (_that) {
case _Terminal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Terminal value)?  $default,){
final _that = this;
switch (_that) {
case _Terminal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? operator, @JsonKey(name: 'wait_time')  int? waitTime, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'routes_available')  int? routesAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Terminal() when $default != null:
return $default(_that.id,_that.name,_that.operator,_that.waitTime,_that.lastUpdated,_that.routesAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? operator, @JsonKey(name: 'wait_time')  int? waitTime, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'routes_available')  int? routesAvailable)  $default,) {final _that = this;
switch (_that) {
case _Terminal():
return $default(_that.id,_that.name,_that.operator,_that.waitTime,_that.lastUpdated,_that.routesAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? operator, @JsonKey(name: 'wait_time')  int? waitTime, @JsonKey(name: 'last_updated')  DateTime? lastUpdated, @JsonKey(name: 'routes_available')  int? routesAvailable)?  $default,) {final _that = this;
switch (_that) {
case _Terminal() when $default != null:
return $default(_that.id,_that.name,_that.operator,_that.waitTime,_that.lastUpdated,_that.routesAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Terminal implements Terminal {
  const _Terminal({required this.id, required this.name, this.operator, @JsonKey(name: 'wait_time') this.waitTime, @JsonKey(name: 'last_updated') this.lastUpdated, @JsonKey(name: 'routes_available') this.routesAvailable});
  factory _Terminal.fromJson(Map<String, dynamic> json) => _$TerminalFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? operator;
// e.g., "BRT anchor", "MyBus main hub"
@override@JsonKey(name: 'wait_time') final  int? waitTime;
// in minutes
@override@JsonKey(name: 'last_updated') final  DateTime? lastUpdated;
@override@JsonKey(name: 'routes_available') final  int? routesAvailable;

/// Create a copy of Terminal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TerminalCopyWith<_Terminal> get copyWith => __$TerminalCopyWithImpl<_Terminal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TerminalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Terminal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.waitTime, waitTime) || other.waitTime == waitTime)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.routesAvailable, routesAvailable) || other.routesAvailable == routesAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,operator,waitTime,lastUpdated,routesAvailable);

@override
String toString() {
  return 'Terminal(id: $id, name: $name, operator: $operator, waitTime: $waitTime, lastUpdated: $lastUpdated, routesAvailable: $routesAvailable)';
}


}

/// @nodoc
abstract mixin class _$TerminalCopyWith<$Res> implements $TerminalCopyWith<$Res> {
  factory _$TerminalCopyWith(_Terminal value, $Res Function(_Terminal) _then) = __$TerminalCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? operator,@JsonKey(name: 'wait_time') int? waitTime,@JsonKey(name: 'last_updated') DateTime? lastUpdated,@JsonKey(name: 'routes_available') int? routesAvailable
});




}
/// @nodoc
class __$TerminalCopyWithImpl<$Res>
    implements _$TerminalCopyWith<$Res> {
  __$TerminalCopyWithImpl(this._self, this._then);

  final _Terminal _self;
  final $Res Function(_Terminal) _then;

/// Create a copy of Terminal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? operator = freezed,Object? waitTime = freezed,Object? lastUpdated = freezed,Object? routesAvailable = freezed,}) {
  return _then(_Terminal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,operator: freezed == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String?,waitTime: freezed == waitTime ? _self.waitTime : waitTime // ignore: cast_nullable_to_non_nullable
as int?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,routesAvailable: freezed == routesAvailable ? _self.routesAvailable : routesAvailable // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
