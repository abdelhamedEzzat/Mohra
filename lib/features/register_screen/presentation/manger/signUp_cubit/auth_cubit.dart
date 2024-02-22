import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      if (e.code == 'weak-password') {
        emit(const Signupfaild(error: 'The password provided is too weak.'));
        if (e.code == 'email-already-in-use') {
          emit(const Signupfaild(
              error: 'The account already exists for that email.'));
        } else if (e.code == 'google_services_blocked') {
          emit(const Loginfaild(
              error:
                  'Google services are blocked in your area. Please try again later.'));
        } else {
          emit(Signupfaild(error: e.message.toString()));
        }
      }
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
      if (e.code == 'user-not-found') {
        emit(const Loginfaild(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(const Loginfaild(error: 'Wrong password provided for that user.'));
      } else if (e.code == 'google_services_blocked') {
        emit(const Loginfaild(
            error:
                'Google services are blocked in your area. Please try again later.'));
      } else {
        emit(Loginfaild(error: e.message.toString()));
      }
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();

    emit(AuthlogOut());
  }

  Future<bool> deleteAccount() async {
    emit(AuthDeleteAccountLoading());
    try {
      // Get the current user
      final currentUser = FirebaseAuth.instance.currentUser;

      // Delete user document from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .delete();

      // Delete user account from Firebase Authentication
      await currentUser!.delete();

      print('Account successfully deleted.');
      emit(AuthDeleteAccountSuccess());
      return true; // Return true indicating successful deletion
    } catch (e) {
      // Handle any errors here
      print('Error deleting account: $e');
      emit(AuthDeleteAccountFaild(
          error: " faild Delete Account ${e.toString()}"));
      return false; // Return false indicating deletion failure
    }
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

  // Future<void> addAuditor(
  //     {required String firstName,
  //     required String lastName,
  //     required String email}) async {
  //   final user = FirebaseAuth.instance.currentUser!.uid;
  //   DocumentReference users = firestore.collection('users').doc(user);

  //   emit(AddAuditorLoading());
  //   try {
  //     users.set({
  //       'first_Name': firstName,
  //       'last_Name': lastName,
  //       'fullName': firstName + lastName,
  //       'userID': user,
  //       'email': email,
  //       'role': 'Auditor',
  //       'status': '2',
  //       'Email_status': 'enabled',
  //     });
  //     emit(AddAuditorSuccess());
  //   } catch (e) {
  //     AddAuditorfaild(error: "Failed to add user:${e.toString()}");
  //   }
  // }

  Future staffAuditorSignUP({
    required String email,
    required String password,
  }) async {
    emit(AddStaffLoading());
    FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: Firebase.app().options,
    );

    try {
      UserCredential credential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credential.user!.uid;
      DocumentReference<Map<String, dynamic>> users =
          firestore.collection('users').doc(uid);
      await users.set(
        {
          'first_Name': firstName,
          'last_Name': lastName,
          'fullName': firstName + lastName,
          'userID': uid, // Use the user's ID here
          'email': email,
          'role': 'Auditor',
          'status': '2',
          'Email_status': 'enabled',
        },
      );
      emit(AddStaffSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AddStafffaild(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AddStafffaild(
            error: 'An account already exists for this email.'));
        return;
      }
    }

// after creating the account, delete the secondary app as below:
    await secondaryApp.delete();
  }

  // Future<void> staffAuditorSignIn({
  //   required String email,
  //   required String password,
  //   required String firstName,
  //   required String lastName,
  // }) async {
  //   emit(SignupLoading());
  //   try {
  //     CollectionReference users = firestore.collection('users');

  //     emit(AddAuditorLoading());
  //     try {
  //       await users.add(
  //         {
  //           'first_Name': firstName,
  //           'last_Name': lastName,
  //           'fullName': firstName + lastName,
  //           'userID': "", // Use the user's ID here
  //           'email': email,
  //           'role': 'Auditor',
  //           'status': '2',
  //           'Email_status': 'enabled',
  //         },
  //       );

  //       emit(AddAuditorSuccess());
  //     } catch (e) {
  //       emit(AddAuditorfaild(error: "Failed to add user:${e.toString()}"));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       emit(Signupfaild(error: 'The password provided is too weak.'));
  //     } else if (e.code == 'email-already-in-use') {
  //       emit(Signupfaild(error: 'An account already exists for this email.'));
  //     } else {
  //       emit(Signupfaild(error: 'An error occurred. Please try again.'));
  //     }
  //   } catch (e) {
  //     emit(Signupfaild(error: 'An error occurred. Please try again.'));
  //   }
  // }

  // Future<void> staffAccountantSignIn({
  //   required String email,
  //   required String password,
  //   required String firstName,
  //   required String lastName,
  // }) async {
  //   emit(SignupLoading());
  //   try {
  //     UserCredential credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);

  //     final user = credential.user!;
  //     CollectionReference users = firestore.collection('users');

  //     emit(AddAuditorLoading());
  //     try {
  //       await users.add(
  //         {
  //           'first_Name': firstName,
  //           'last_Name': lastName,
  //           'fullName': firstName + lastName,
  //           'userID': user,
  //           'email': email,
  //           'role': 'Accountant',
  //           'status': '2',
  //           'Email_status': 'enabled',
  //         },
  //       );

  //       emit(AddAuditorSuccess());
  //     } catch (e) {
  //       emit(AddAuditorfaild(error: "Failed to add user:${e.toString()}"));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       emit(Signupfaild(error: 'The password provided is too weak.'));
  //     } else if (e.code == 'email-already-in-use') {
  //       emit(Signupfaild(error: 'An account already exists for this email.'));
  //     } else {
  //       emit(Signupfaild(error: 'An error occurred. Please try again.'));
  //     }
  //   } catch (e) {
  //     emit(Signupfaild(error: 'An error occurred. Please try again.'));
  //   }
  // }

  // Future<void> addAccountant({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String password,
  // }) async {
  //   // await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   //   email: email,
  //   //   password: password,
  //   // );
  //   final user = FirebaseAuth.instance.currentUser!.uid;
  //   DocumentReference users = firestore.collection('users').doc(user);

  //   emit(AddAuditorLoading());
  //   try {
  //     users.set({
  //       'first_Name': firstName,
  //       'last_Name': lastName,
  //       'fullName': firstName + lastName,
  //       'userID': user,
  //       'email': email,
  //       'role': 'Accountant',
  //       'status': '2',
  //       'Email_status': 'enabled',
  //     });
  //     emit(AddAuditorSuccess());
  //   } catch (e) {
  //     AddAuditorfaild(error: "Failed to add user:${e.toString()}");
  //   }
  // }
  Future staffAccontantSignUP({
    required String email,
    required String password,
  }) async {
    emit(AddStaffLoading());
    FirebaseApp secondaryApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: Firebase.app().options,
    );

    try {
      UserCredential credential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credential.user!.uid;
      DocumentReference<Map<String, dynamic>> users =
          firestore.collection('users').doc(uid);
      await users.set(
        {
          'first_Name': firstName,
          'last_Name': lastName,
          'fullName': firstName + lastName,
          'userID': uid, // Use the user's ID here
          'email': email,
          'role': 'Accountant',
          'status': '2',
          'Email_status': 'enabled',
        },
      );
      emit(AddStaffSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AddStafffaild(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AddStafffaild(
            error: 'An account already exists for this email.'));
        return;
      }
    }

// after creating the account, delete the secondary app as below:
    await secondaryApp.delete();
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

  // void checkRole(context) async {
  //   try {
  //     emit(UserStutsLoading());
  //     DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
  //         .instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();

  //     String userRole = userData['role']; // Access the 'role' field

  //     // Now you can check the user's role and navigate accordingly
  //     if (userRole == 'admin') {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         RouterName.adminHomeScreen,
  //         (route) => false,
  //       );
  //     } else if (userRole == 'Accountant') {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         RouterName.accountantHomeScreen,
  //         (route) => false,
  //       );
  //     } else if (userRole == 'Auditor') {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         RouterName.auditorHomeScreen,
  //         (route) => false,
  //       );
  //     } else if (userRole == 'Users') {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         RouterName.homeScreenForUser,
  //         (route) => false,
  //       );
  //     }
  //     emit(UserStutsSuccess());
  //   } catch (e) {
  //     emit(UserStutsfaild(error: "Failed to get  user:${e.toString()}"));
  //   }
  // }

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
