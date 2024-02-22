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
//add Aditor
//
final class AddStaffInitial extends AuthState {}

final class AddStaffLoading extends AuthState {}

final class AddStaffSuccess extends AuthState {}

final class AddStafffaild extends AuthState {
  final String error;

  const AddStafffaild({required this.error});
}

//
// for log out
//
final class AuthlogOut extends AuthState {}

//
// for Delete account
//
final class AuthDeleteAccountSuccess extends AuthState {}

final class AuthDeleteAccountLoading extends AuthState {}

final class AuthDeleteAccountFaild extends AuthState {
  final String error;

  const AuthDeleteAccountFaild({required this.error});
}

//
// for Reset account
//
final class AuthResetAccount extends AuthState {}

//
// for Verify account
//
final class VerifyAccount extends AuthState {}

//
//
//
final class UserStutsLoading extends AuthState {}

final class UserStutsSuccess extends AuthState {}

final class UserStutsfaild extends AuthState {
  final String error;

  const UserStutsfaild({required this.error});
}
//
//
//

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  final String error;

  const AuthUnauthenticated({required this.error});
}
