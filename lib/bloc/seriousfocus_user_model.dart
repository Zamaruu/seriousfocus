import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  late String uid;
  late String displayName;
  late String _email;
  late bool _emailVisible;
  bool get emailVisible => _emailVisible;
  late bool _isLocalUser;
  bool get isLocalUser => _isLocalUser;
  late int userColor;

  UserModel.localUser(User currentUser, bool emailVisible, int userColor) {
    this.uid = currentUser.uid;
    this.displayName = currentUser.displayName ?? "";
    this._email = currentUser.email ?? "";
    this._emailVisible = emailVisible;
    this._isLocalUser = true;
    this.userColor = userColor;
  }

  UserModel.apiStorage({
    required this.uid,
    required email,
    required emailVisible,
    required this.displayName,
    required this.userColor,
  }){
    this._email = email;
    this._emailVisible = emailVisible;
    this._isLocalUser = false;
  }

  //Returns email only when the local user is accessing it or the remote user allowed this.
  String getEmail() {
    if (_isLocalUser) {
      return _email;
    } else if (_emailVisible) {
      return _email;
    } else {
      return "";
    }
  }

  Future<void> changeUserColor(Color newColor) async {
    if (_isLocalUser) {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(uid)
          .update({"usercolor": newColor.value});
    } else {
      return;
    }
  }

  Future<void> changeEmailVisibleStatus(bool newValue) async {
    if (_isLocalUser) {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(uid)
          .update({"emailvisible": newValue});
    } else {
      return;
    }
  }
}
