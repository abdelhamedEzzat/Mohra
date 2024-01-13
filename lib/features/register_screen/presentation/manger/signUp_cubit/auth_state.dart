part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}
//
// for Signup
//

final class SignupLoading extends AuthState {}

final class SignupSuccess extends AuthState {}

final class Signupfaild extends AuthState {
  final String error;

  const Signupfaild({required this.error});
}

//
//for Signin
//
final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class Loginfaild extends AuthState {
  final String error;

  const Loginfaild({required this.error});
}

//
// for log out
//
final class AuthlogOut extends AuthState {}

//
// for Delete account
//
final class AuthDeleteAccount extends AuthState {}

//
// for Reset account
//
final class AuthResetAccount extends AuthState {}

//
// for Verify account
//
final class VerifyAccount extends AuthState {}