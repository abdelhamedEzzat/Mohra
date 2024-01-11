part of 'signup_cubit.dart';

sealed class SignupState {
  const SignupState();
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class Signupfaild extends SignupState {
  final String error;

  const Signupfaild({required this.error});
}
