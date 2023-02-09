import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      //Here you catch the specific error
      if (e.code == 'wrong-password') {
        print('Wrong pass');
        //The thing that should happen if the password is incorrect
        //In my case it will the change the hinttext
        // setState(() {
        //   hintTextPassword = 'Password incorrect. Please try again';
        //   passwordHintColor = Colors.red;
        // });
      } else if (e.code == 'user-not-found') {
        print('Not found');
      }
    } catch (e) {
      print(e);
    }
  }
}
