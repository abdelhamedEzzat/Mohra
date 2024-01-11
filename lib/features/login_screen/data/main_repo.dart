import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class MainRepostory {
  Stream<auth.User?> get user;
  Future<auth.User?> login({required String email, required String password});
}
