import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/utils/display_toast_message.dart';
import 'package:lead_management_system/utils/firebase_collections.dart';

class AuthService extends GetConnect {
  Future<UserCredential?> signUpUser(
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic> data = {
        "uid": userCredential.user!.uid,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "notification": true,
      };
      if (userCredential.user != null) {
        await userCollection.doc(userCredential.user!.uid).set(data);
        await userCredential.user!.sendEmailVerification();
        userCredential.user?.updateDisplayName('$firstName $lastName');
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayToastMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        displayToastMessage('The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<UserCredential?> logInUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayToastMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        displayToastMessage('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<UserCredential?> updatePassword(String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final emailProviderCred = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: currentPassword,
      );
      UserCredential userCredential = await user!.reauthenticateWithCredential(emailProviderCred);
      userCredential.user?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
    return null;
  }
}
