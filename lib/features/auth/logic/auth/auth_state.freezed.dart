// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
          _$AuthInitialImpl value, $Res Function(_$AuthInitialImpl) then) =
      __$$AuthInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
      _$AuthInitialImpl _value, $Res Function(_$AuthInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthInitialImpl implements AuthInitial {
  const _$AuthInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitialImpl;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppUser user});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthenticatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl implements Authenticated {
  const _$AuthenticatedImpl(this.user);

  @override
  final AppUser user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AuthState {
  const factory Authenticated(final AppUser user) = _$AuthenticatedImpl;

  AppUser get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl implements Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class Unauthenticated implements AuthState {
  const factory Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(final String message) = _$AuthErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisterPasswordObsecureImplCopyWith<$Res> {
  factory _$$RegisterPasswordObsecureImplCopyWith(
          _$RegisterPasswordObsecureImpl value,
          $Res Function(_$RegisterPasswordObsecureImpl) then) =
      __$$RegisterPasswordObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterPasswordObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegisterPasswordObsecureImpl>
    implements _$$RegisterPasswordObsecureImplCopyWith<$Res> {
  __$$RegisterPasswordObsecureImplCopyWithImpl(
      _$RegisterPasswordObsecureImpl _value,
      $Res Function(_$RegisterPasswordObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterPasswordObsecureImpl implements RegisterPasswordObsecure {
  const _$RegisterPasswordObsecureImpl();

  @override
  String toString() {
    return 'AuthState.registerPasswordObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterPasswordObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return registerPasswordObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return registerPasswordObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordObsecure != null) {
      return registerPasswordObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return registerPasswordObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return registerPasswordObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordObsecure != null) {
      return registerPasswordObsecure(this);
    }
    return orElse();
  }
}

abstract class RegisterPasswordObsecure implements AuthState {
  const factory RegisterPasswordObsecure() = _$RegisterPasswordObsecureImpl;
}

/// @nodoc
abstract class _$$RegisterPasswordNotObsecureImplCopyWith<$Res> {
  factory _$$RegisterPasswordNotObsecureImplCopyWith(
          _$RegisterPasswordNotObsecureImpl value,
          $Res Function(_$RegisterPasswordNotObsecureImpl) then) =
      __$$RegisterPasswordNotObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterPasswordNotObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegisterPasswordNotObsecureImpl>
    implements _$$RegisterPasswordNotObsecureImplCopyWith<$Res> {
  __$$RegisterPasswordNotObsecureImplCopyWithImpl(
      _$RegisterPasswordNotObsecureImpl _value,
      $Res Function(_$RegisterPasswordNotObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterPasswordNotObsecureImpl implements RegisterPasswordNotObsecure {
  const _$RegisterPasswordNotObsecureImpl();

  @override
  String toString() {
    return 'AuthState.registerPasswordNotObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterPasswordNotObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return registerPasswordNotObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return registerPasswordNotObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordNotObsecure != null) {
      return registerPasswordNotObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return registerPasswordNotObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return registerPasswordNotObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordNotObsecure != null) {
      return registerPasswordNotObsecure(this);
    }
    return orElse();
  }
}

abstract class RegisterPasswordNotObsecure implements AuthState {
  const factory RegisterPasswordNotObsecure() =
      _$RegisterPasswordNotObsecureImpl;
}

/// @nodoc
abstract class _$$RegisterPasswordConfirmationObsecureImplCopyWith<$Res> {
  factory _$$RegisterPasswordConfirmationObsecureImplCopyWith(
          _$RegisterPasswordConfirmationObsecureImpl value,
          $Res Function(_$RegisterPasswordConfirmationObsecureImpl) then) =
      __$$RegisterPasswordConfirmationObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterPasswordConfirmationObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res,
        _$RegisterPasswordConfirmationObsecureImpl>
    implements _$$RegisterPasswordConfirmationObsecureImplCopyWith<$Res> {
  __$$RegisterPasswordConfirmationObsecureImplCopyWithImpl(
      _$RegisterPasswordConfirmationObsecureImpl _value,
      $Res Function(_$RegisterPasswordConfirmationObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterPasswordConfirmationObsecureImpl
    implements RegisterPasswordConfirmationObsecure {
  const _$RegisterPasswordConfirmationObsecureImpl();

  @override
  String toString() {
    return 'AuthState.registerPasswordConfirmationObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterPasswordConfirmationObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return registerPasswordConfirmationObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return registerPasswordConfirmationObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordConfirmationObsecure != null) {
      return registerPasswordConfirmationObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return registerPasswordConfirmationObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return registerPasswordConfirmationObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordConfirmationObsecure != null) {
      return registerPasswordConfirmationObsecure(this);
    }
    return orElse();
  }
}

abstract class RegisterPasswordConfirmationObsecure implements AuthState {
  const factory RegisterPasswordConfirmationObsecure() =
      _$RegisterPasswordConfirmationObsecureImpl;
}

/// @nodoc
abstract class _$$RegisterPasswordConfirmationNotObsecureImplCopyWith<$Res> {
  factory _$$RegisterPasswordConfirmationNotObsecureImplCopyWith(
          _$RegisterPasswordConfirmationNotObsecureImpl value,
          $Res Function(_$RegisterPasswordConfirmationNotObsecureImpl) then) =
      __$$RegisterPasswordConfirmationNotObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterPasswordConfirmationNotObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res,
        _$RegisterPasswordConfirmationNotObsecureImpl>
    implements _$$RegisterPasswordConfirmationNotObsecureImplCopyWith<$Res> {
  __$$RegisterPasswordConfirmationNotObsecureImplCopyWithImpl(
      _$RegisterPasswordConfirmationNotObsecureImpl _value,
      $Res Function(_$RegisterPasswordConfirmationNotObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterPasswordConfirmationNotObsecureImpl
    implements RegisterPasswordConfirmationNotObsecure {
  const _$RegisterPasswordConfirmationNotObsecureImpl();

  @override
  String toString() {
    return 'AuthState.registerPasswordConfirmationNotObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterPasswordConfirmationNotObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return registerPasswordConfirmationNotObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return registerPasswordConfirmationNotObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordConfirmationNotObsecure != null) {
      return registerPasswordConfirmationNotObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return registerPasswordConfirmationNotObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return registerPasswordConfirmationNotObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (registerPasswordConfirmationNotObsecure != null) {
      return registerPasswordConfirmationNotObsecure(this);
    }
    return orElse();
  }
}

abstract class RegisterPasswordConfirmationNotObsecure implements AuthState {
  const factory RegisterPasswordConfirmationNotObsecure() =
      _$RegisterPasswordConfirmationNotObsecureImpl;
}

/// @nodoc
abstract class _$$LoginPasswordObsecureImplCopyWith<$Res> {
  factory _$$LoginPasswordObsecureImplCopyWith(
          _$LoginPasswordObsecureImpl value,
          $Res Function(_$LoginPasswordObsecureImpl) then) =
      __$$LoginPasswordObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginPasswordObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoginPasswordObsecureImpl>
    implements _$$LoginPasswordObsecureImplCopyWith<$Res> {
  __$$LoginPasswordObsecureImplCopyWithImpl(_$LoginPasswordObsecureImpl _value,
      $Res Function(_$LoginPasswordObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginPasswordObsecureImpl implements LoginPasswordObsecure {
  const _$LoginPasswordObsecureImpl();

  @override
  String toString() {
    return 'AuthState.loginPasswordObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return loginPasswordObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return loginPasswordObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (loginPasswordObsecure != null) {
      return loginPasswordObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return loginPasswordObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return loginPasswordObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (loginPasswordObsecure != null) {
      return loginPasswordObsecure(this);
    }
    return orElse();
  }
}

abstract class LoginPasswordObsecure implements AuthState {
  const factory LoginPasswordObsecure() = _$LoginPasswordObsecureImpl;
}

/// @nodoc
abstract class _$$LoginPasswordNotObsecureImplCopyWith<$Res> {
  factory _$$LoginPasswordNotObsecureImplCopyWith(
          _$LoginPasswordNotObsecureImpl value,
          $Res Function(_$LoginPasswordNotObsecureImpl) then) =
      __$$LoginPasswordNotObsecureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginPasswordNotObsecureImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoginPasswordNotObsecureImpl>
    implements _$$LoginPasswordNotObsecureImplCopyWith<$Res> {
  __$$LoginPasswordNotObsecureImplCopyWithImpl(
      _$LoginPasswordNotObsecureImpl _value,
      $Res Function(_$LoginPasswordNotObsecureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginPasswordNotObsecureImpl implements LoginPasswordNotObsecure {
  const _$LoginPasswordNotObsecureImpl();

  @override
  String toString() {
    return 'AuthState.loginPasswordNotObsecure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordNotObsecureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return loginPasswordNotObsecure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return loginPasswordNotObsecure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (loginPasswordNotObsecure != null) {
      return loginPasswordNotObsecure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return loginPasswordNotObsecure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return loginPasswordNotObsecure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (loginPasswordNotObsecure != null) {
      return loginPasswordNotObsecure(this);
    }
    return orElse();
  }
}

abstract class LoginPasswordNotObsecure implements AuthState {
  const factory LoginPasswordNotObsecure() = _$LoginPasswordNotObsecureImpl;
}

/// @nodoc
abstract class _$$PasswordValidationsStateImplCopyWith<$Res> {
  factory _$$PasswordValidationsStateImplCopyWith(
          _$PasswordValidationsStateImpl value,
          $Res Function(_$PasswordValidationsStateImpl) then) =
      __$$PasswordValidationsStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {bool hasLowercase,
      bool hasUppercase,
      bool hasSpecialCharacters,
      bool hasNumber,
      bool hasMinLength});
}

/// @nodoc
class __$$PasswordValidationsStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$PasswordValidationsStateImpl>
    implements _$$PasswordValidationsStateImplCopyWith<$Res> {
  __$$PasswordValidationsStateImplCopyWithImpl(
      _$PasswordValidationsStateImpl _value,
      $Res Function(_$PasswordValidationsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasLowercase = null,
    Object? hasUppercase = null,
    Object? hasSpecialCharacters = null,
    Object? hasNumber = null,
    Object? hasMinLength = null,
  }) {
    return _then(_$PasswordValidationsStateImpl(
      hasLowercase: null == hasLowercase
          ? _value.hasLowercase
          : hasLowercase // ignore: cast_nullable_to_non_nullable
              as bool,
      hasUppercase: null == hasUppercase
          ? _value.hasUppercase
          : hasUppercase // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSpecialCharacters: null == hasSpecialCharacters
          ? _value.hasSpecialCharacters
          : hasSpecialCharacters // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNumber: null == hasNumber
          ? _value.hasNumber
          : hasNumber // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMinLength: null == hasMinLength
          ? _value.hasMinLength
          : hasMinLength // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PasswordValidationsStateImpl implements PasswordValidationsState {
  const _$PasswordValidationsStateImpl(
      {required this.hasLowercase,
      required this.hasUppercase,
      required this.hasSpecialCharacters,
      required this.hasNumber,
      required this.hasMinLength});

  @override
  final bool hasLowercase;
  @override
  final bool hasUppercase;
  @override
  final bool hasSpecialCharacters;
  @override
  final bool hasNumber;
  @override
  final bool hasMinLength;

  @override
  String toString() {
    return 'AuthState.passwordValidations(hasLowercase: $hasLowercase, hasUppercase: $hasUppercase, hasSpecialCharacters: $hasSpecialCharacters, hasNumber: $hasNumber, hasMinLength: $hasMinLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordValidationsStateImpl &&
            (identical(other.hasLowercase, hasLowercase) ||
                other.hasLowercase == hasLowercase) &&
            (identical(other.hasUppercase, hasUppercase) ||
                other.hasUppercase == hasUppercase) &&
            (identical(other.hasSpecialCharacters, hasSpecialCharacters) ||
                other.hasSpecialCharacters == hasSpecialCharacters) &&
            (identical(other.hasNumber, hasNumber) ||
                other.hasNumber == hasNumber) &&
            (identical(other.hasMinLength, hasMinLength) ||
                other.hasMinLength == hasMinLength));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasLowercase, hasUppercase,
      hasSpecialCharacters, hasNumber, hasMinLength);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordValidationsStateImplCopyWith<_$PasswordValidationsStateImpl>
      get copyWith => __$$PasswordValidationsStateImplCopyWithImpl<
          _$PasswordValidationsStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String message) error,
    required TResult Function() registerPasswordObsecure,
    required TResult Function() registerPasswordNotObsecure,
    required TResult Function() registerPasswordConfirmationObsecure,
    required TResult Function() registerPasswordConfirmationNotObsecure,
    required TResult Function() loginPasswordObsecure,
    required TResult Function() loginPasswordNotObsecure,
    required TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)
        passwordValidations,
  }) {
    return passwordValidations(hasLowercase, hasUppercase, hasSpecialCharacters,
        hasNumber, hasMinLength);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String message)? error,
    TResult? Function()? registerPasswordObsecure,
    TResult? Function()? registerPasswordNotObsecure,
    TResult? Function()? registerPasswordConfirmationObsecure,
    TResult? Function()? registerPasswordConfirmationNotObsecure,
    TResult? Function()? loginPasswordObsecure,
    TResult? Function()? loginPasswordNotObsecure,
    TResult? Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
  }) {
    return passwordValidations?.call(hasLowercase, hasUppercase,
        hasSpecialCharacters, hasNumber, hasMinLength);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String message)? error,
    TResult Function()? registerPasswordObsecure,
    TResult Function()? registerPasswordNotObsecure,
    TResult Function()? registerPasswordConfirmationObsecure,
    TResult Function()? registerPasswordConfirmationNotObsecure,
    TResult Function()? loginPasswordObsecure,
    TResult Function()? loginPasswordNotObsecure,
    TResult Function(bool hasLowercase, bool hasUppercase,
            bool hasSpecialCharacters, bool hasNumber, bool hasMinLength)?
        passwordValidations,
    required TResult orElse(),
  }) {
    if (passwordValidations != null) {
      return passwordValidations(hasLowercase, hasUppercase,
          hasSpecialCharacters, hasNumber, hasMinLength);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(RegisterPasswordObsecure value)
        registerPasswordObsecure,
    required TResult Function(RegisterPasswordNotObsecure value)
        registerPasswordNotObsecure,
    required TResult Function(RegisterPasswordConfirmationObsecure value)
        registerPasswordConfirmationObsecure,
    required TResult Function(RegisterPasswordConfirmationNotObsecure value)
        registerPasswordConfirmationNotObsecure,
    required TResult Function(LoginPasswordObsecure value)
        loginPasswordObsecure,
    required TResult Function(LoginPasswordNotObsecure value)
        loginPasswordNotObsecure,
    required TResult Function(PasswordValidationsState value)
        passwordValidations,
  }) {
    return passwordValidations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult? Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult? Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult? Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult? Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult? Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult? Function(PasswordValidationsState value)? passwordValidations,
  }) {
    return passwordValidations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthError value)? error,
    TResult Function(RegisterPasswordObsecure value)? registerPasswordObsecure,
    TResult Function(RegisterPasswordNotObsecure value)?
        registerPasswordNotObsecure,
    TResult Function(RegisterPasswordConfirmationObsecure value)?
        registerPasswordConfirmationObsecure,
    TResult Function(RegisterPasswordConfirmationNotObsecure value)?
        registerPasswordConfirmationNotObsecure,
    TResult Function(LoginPasswordObsecure value)? loginPasswordObsecure,
    TResult Function(LoginPasswordNotObsecure value)? loginPasswordNotObsecure,
    TResult Function(PasswordValidationsState value)? passwordValidations,
    required TResult orElse(),
  }) {
    if (passwordValidations != null) {
      return passwordValidations(this);
    }
    return orElse();
  }
}

abstract class PasswordValidationsState implements AuthState {
  const factory PasswordValidationsState(
      {required final bool hasLowercase,
      required final bool hasUppercase,
      required final bool hasSpecialCharacters,
      required final bool hasNumber,
      required final bool hasMinLength}) = _$PasswordValidationsStateImpl;

  bool get hasLowercase;
  bool get hasUppercase;
  bool get hasSpecialCharacters;
  bool get hasNumber;
  bool get hasMinLength;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordValidationsStateImplCopyWith<_$PasswordValidationsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
