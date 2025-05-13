// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_user_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetUsersResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetUsersResult()';
}


}

/// @nodoc
class $GetUsersResultCopyWith<$Res>  {
$GetUsersResultCopyWith(GetUsersResult _, $Res Function(GetUsersResult) __);
}


/// @nodoc


class GetUsersLoading implements GetUsersResult {
  const GetUsersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetUsersResult.loading()';
}


}




/// @nodoc


class GetUsersLoaded implements GetUsersResult {
  const GetUsersLoaded(final  List<Quote> quotes): _quotes = quotes;
  

 final  List<Quote> _quotes;
 List<Quote> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}


/// Create a copy of GetUsersResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetUsersLoadedCopyWith<GetUsersLoaded> get copyWith => _$GetUsersLoadedCopyWithImpl<GetUsersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersLoaded&&const DeepCollectionEquality().equals(other._quotes, _quotes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_quotes));

@override
String toString() {
  return 'GetUsersResult.loaded(quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class $GetUsersLoadedCopyWith<$Res> implements $GetUsersResultCopyWith<$Res> {
  factory $GetUsersLoadedCopyWith(GetUsersLoaded value, $Res Function(GetUsersLoaded) _then) = _$GetUsersLoadedCopyWithImpl;
@useResult
$Res call({
 List<Quote> quotes
});




}
/// @nodoc
class _$GetUsersLoadedCopyWithImpl<$Res>
    implements $GetUsersLoadedCopyWith<$Res> {
  _$GetUsersLoadedCopyWithImpl(this._self, this._then);

  final GetUsersLoaded _self;
  final $Res Function(GetUsersLoaded) _then;

/// Create a copy of GetUsersResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quotes = null,}) {
  return _then(GetUsersLoaded(
null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<Quote>,
  ));
}


}

/// @nodoc


class GetUsersError implements GetUsersResult {
  const GetUsersError(this.message);
  

 final  String message;

/// Create a copy of GetUsersResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetUsersErrorCopyWith<GetUsersError> get copyWith => _$GetUsersErrorCopyWithImpl<GetUsersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GetUsersResult.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $GetUsersErrorCopyWith<$Res> implements $GetUsersResultCopyWith<$Res> {
  factory $GetUsersErrorCopyWith(GetUsersError value, $Res Function(GetUsersError) _then) = _$GetUsersErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GetUsersErrorCopyWithImpl<$Res>
    implements $GetUsersErrorCopyWith<$Res> {
  _$GetUsersErrorCopyWithImpl(this._self, this._then);

  final GetUsersError _self;
  final $Res Function(GetUsersError) _then;

/// Create a copy of GetUsersResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GetUsersError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GetUsersNothing implements GetUsersResult {
  const GetUsersNothing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetUsersNothing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetUsersResult.nothing()';
}


}




// dart format on
