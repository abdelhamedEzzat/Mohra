import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohra_project/features/login_screen/presentation/manger/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  String emailCubit = "";
  String passwordCubit = "";

  Future userSignin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      // final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(Loginfaild(error: e.message.toString()));
    }
  }
}
