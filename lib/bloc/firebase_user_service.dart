import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  FirebaseAuth? _firebaseAuth;

  UserService(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<String> uploadFile(File image) async {
    String downloadURL;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images/${_firebaseAuth!.currentUser!.uid}");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}