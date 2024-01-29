import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mohra_project/core/routes/name_router.dart';
import 'package:mohra_project/features/register_screen/data/user_auth.dart';

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
        'status': '0',
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
        'status': '2',
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
        'status': '2',
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

  // void updateUserStatus(int status) {
  //   final userStatusBox = Hive.box<UserStatusModel>('userStatusBox');
  //   final userStatus = UserStatusModel(emailStauts: status);
  //   userStatusBox.put('userStatus', userStatus);
  // }

  // int getUserStatus() {
  //   final userStatusBox = Hive.box<UserStatusModel>('userStatusBox');
  //   final userStatus = userStatusBox.get('userStatus',
  //       defaultValue: UserStatusModel(emailStauts: 0));
  //   return userStatus!.emailStauts;
  // }

  void checkRole(context) async {
    try {
      emit(UserStutsLoading());
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String userRole = userData['role']; // Access the 'role' field

      // Now you can check the user's role and navigate accordingly
      if (userRole == 'admin') {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(RouterName.adminHomeScreen);
      } else if (userRole == 'Accountant') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacementNamed(RouterName.accountantHomeScreen);
      } else if (userRole == 'Auditor') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacementNamed(RouterName.auditorHomeScreen);
      } else if (userRole == 'Users') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacementNamed(RouterName.homeScreenForUser);
      }
      emit(UserStutsSuccess());
    } catch (e) {
      emit(UserStutsfaild(error: "Failed to get  user:${e.toString()}"));
    }
  }
}
