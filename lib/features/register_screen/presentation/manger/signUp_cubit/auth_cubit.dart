import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String emailCubit = "";
  String passwordCubit = "";

  Future userSignUP({
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(Signupfaild(error: e.message.toString()));
    }
  }

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

  Future logOut() async {
    await FirebaseAuth.instance.signOut();

    emit(AuthlogOut());
  }

  Future deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }

    emit(AuthDeleteAccount());
  }

  Future resetAccount() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailCubit);

    emit(AuthResetAccount());
  }

  Future verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
    emit(VerifyAccount());
  }

  // Future checkverifyEmail() async {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user != null && user.emailVerified) {
  //       // Redirect to the homepage
  //       Navigator.pushReplacementNamed(context, '/homepage');
  //     }
  //   });
  // }
}
