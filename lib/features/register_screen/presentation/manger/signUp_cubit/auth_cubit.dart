import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohra_project/core/routes/name_router.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String emailCubit = "";
  String passwordCubit = "";
  String firstName = "";
  String lastName = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user;
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

  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is null (not signed in)
      emit(const Signupfaild(error: "User is not signed in."));
      return;
    }

    DocumentReference users = firestore.collection('users').doc(user.uid);

    emit(SignupLoading());

    try {
      users.set({
        'first_Name': firstName,
        'last_Name': lastName,
        'fullName': firstName + lastName,
        'userID': user.uid,
        'email': email,
        'role': 'User',
        'status': '0',
        'Email_status': 'disabled',
      });
      emit(SignupSuccess());
    } catch (e) {
      emit(Signupfaild(error: "Failed to add user: ${e.toString()}"));
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
        'Email_status': 'enabled',
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
        'Email_status': 'enabled',
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
      // Print the data in the console

      emit(SignupSuccess());
    } catch (e) {
      Signupfaild(error: "Failed to get user:${e.toString()}");
    }
  }

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
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouterName.adminHomeScreen,
          (route) => false,
        );
      } else if (userRole == 'Accountant') {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouterName.accountantHomeScreen,
          (route) => false,
        );
      } else if (userRole == 'Auditor') {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouterName.auditorHomeScreen,
          (route) => false,
        );
      } else if (userRole == 'Users') {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouterName.homeScreenForUser,
          (route) => false,
        );
      }
      emit(UserStutsSuccess());
    } catch (e) {
      emit(UserStutsfaild(error: "Failed to get  user:${e.toString()}"));
    }
  }

  Future signInWithGoogle() async {
    try {
      emit(AuthLoading());
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      // Obtain the auth details from the request
      else {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        user = authResult.user!;
        emit(AuthAuthenticated(user!));
      }
    } on Exception catch (e) {
      emit(AuthUnauthenticated(error: e.toString()));
    }
  }

  Future<void> storeUserInfoInFirestore(User user) async {
    //  final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'fullName': user.displayName,
        'email': user.email,
        'first_Name': user.displayName?.split(" ").first,
        'last_Name': user.displayName?.split(" ").last,
        'role': 'User',
        'status': '0',
        'Email_status': 'disabled',
        // Add more fields as needed
      });
    } catch (e) {
      print('Error storing user information in Firestore: $e');
    }
  }
}
