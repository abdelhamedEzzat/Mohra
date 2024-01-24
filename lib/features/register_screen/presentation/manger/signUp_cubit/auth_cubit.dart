import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String emailCubit = "";
  String passwordCubit = "";
  String firstName = "";
  String lastName = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> personalUserInformation = [];

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
        // ignore: avoid_print
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

  Future<void> addUser(
      {required String firstName,
      required String lastName,
      required String email}) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference users = firestore.collection('users').doc(user);

    emit(SignupLoading());
    try {
      users.set({
        'first_Name': firstName,
        'last_Name': lastName,
        'fullName': firstName + lastName,
        'userID': user,
        'email': email,
        'role': 'User',
        'Email_status': 'disabled',
      });
      emit(SignupSuccess());
    } catch (e) {
      Signupfaild(error: "Failed to add user:${e.toString()}");
    }
  }

  Future<void> addAuditor(
      {required String firstName,
      required String lastName,
      required String email}) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference users = firestore.collection('users').doc(user);

    emit(SignupLoading());
    try {
      users.set({
        'first_Name': firstName,
        'last_Name': lastName,
        'fullName': firstName + lastName,
        'userID': user,
        'email': email,
        'role': 'Auditor',
      });
      emit(SignupSuccess());
    } catch (e) {
      Signupfaild(error: "Failed to add user:${e.toString()}");
    }
  }

  Future<void> addAccountant(
      {required String firstName,
      required String lastName,
      required String email}) async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference users = firestore.collection('users').doc(user);

    emit(SignupLoading());
    try {
      users.set({
        'first_Name': firstName,
        'last_Name': lastName,
        'fullName': firstName + lastName,
        'userID': user,
        'email': email,
        'role': 'Accountant',
      });
      emit(SignupSuccess());
    } catch (e) {
      Signupfaild(error: "Failed to add user:${e.toString()}");
    }
  }

  Future<void> getUserdata() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      //
      //
      personalUserInformation.addAll(querySnapshot.docs);

      emit(SignupSuccess());
    } catch (e) {
      Signupfaild(error: "Failed to get user:${e.toString()}");
    }
  }
}
