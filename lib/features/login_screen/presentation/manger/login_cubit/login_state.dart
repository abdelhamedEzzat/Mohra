sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class Loginfaild extends LoginState {
  final String error;

  const Loginfaild({required this.error});
}
