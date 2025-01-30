// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/get_auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetAuth {
  String? get sessionId => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;

  /// Create a copy of GetAuth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAuthCopyWith<GetAuth> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAuthCopyWith<$Res> {
  factory $GetAuthCopyWith(GetAuth value, $Res Function(GetAuth) then) =
      _$GetAuthCopyWithImpl<$Res, GetAuth>;
  @useResult
  $Res call({String? sessionId, String? deviceId});
}

/// @nodoc
class _$GetAuthCopyWithImpl<$Res, $Val extends GetAuth>
    implements $GetAuthCopyWith<$Res> {
  _$GetAuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAuth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_value.copyWith(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAuthImplCopyWith<$Res> implements $GetAuthCopyWith<$Res> {
  factory _$$GetAuthImplCopyWith(
          _$GetAuthImpl value, $Res Function(_$GetAuthImpl) then) =
      __$$GetAuthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? sessionId, String? deviceId});
}

/// @nodoc
class __$$GetAuthImplCopyWithImpl<$Res>
    extends _$GetAuthCopyWithImpl<$Res, _$GetAuthImpl>
    implements _$$GetAuthImplCopyWith<$Res> {
  __$$GetAuthImplCopyWithImpl(
      _$GetAuthImpl _value, $Res Function(_$GetAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAuth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_$GetAuthImpl(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GetAuthImpl with DiagnosticableTreeMixin implements _GetAuth {
  _$GetAuthImpl({required this.sessionId, required this.deviceId});

  @override
  final String? sessionId;
  @override
  final String? deviceId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetAuth(sessionId: $sessionId, deviceId: $deviceId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetAuth'))
      ..add(DiagnosticsProperty('sessionId', sessionId))
      ..add(DiagnosticsProperty('deviceId', deviceId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAuthImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, deviceId);

  /// Create a copy of GetAuth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAuthImplCopyWith<_$GetAuthImpl> get copyWith =>
      __$$GetAuthImplCopyWithImpl<_$GetAuthImpl>(this, _$identity);
}

abstract class _GetAuth implements GetAuth {
  factory _GetAuth(
      {required final String? sessionId,
      required final String? deviceId}) = _$GetAuthImpl;

  @override
  String? get sessionId;
  @override
  String? get deviceId;

  /// Create a copy of GetAuth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAuthImplCopyWith<_$GetAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
