import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService extends ChangeNotifier {

  AuthenticationService();

  Future<String> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
        notifyListeners();
        return "200";
      } else {
        return "400";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "200";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp({required String email, required String password, required String username}) async {
    try {
      UserCredential newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await newUser.user!.updateDisplayName(username);
      FirebaseFirestore.instance.collection("User").doc(newUser.user!.uid).set(
        {
          "uid": newUser.user!.uid,
          "email": email,
          "username": username,
        }
      );
      //signIn(email: email, password: password);
      return "200";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future logout() async {
    FirebaseAuth.instance.signOut();
  }
}