import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/seriousfocus_user_model.dart';

class UserService {
  FirebaseAuth? _firebaseAuth;

  UserService(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<UserModel> getCurrentUser() async {
    DocumentSnapshot<Map<String, dynamic>> firestoreUserRaw = await FirebaseFirestore.instance.collection("User").doc(_firebaseAuth!.currentUser!.uid).get();
    bool emailVisible = firestoreUserRaw["emailvisible"];
    int userColor = firestoreUserRaw["usercolor"];
    return new UserModel.localUser(_firebaseAuth!.currentUser!, emailVisible, userColor);
  }

  Future<List<UserModel>> getAllUsers({required String query}) async {
    List<UserModel> users = <UserModel>[];
    late Map<String, dynamic> data;
    late QuerySnapshot result;

    if(query.isEmpty){
      result = await FirebaseFirestore.instance.collection("User").get();
    }
    else{
      result = await FirebaseFirestore.instance.collection("User")
        .where("username", isGreaterThanOrEqualTo: query.trim())
        .where("username", isLessThanOrEqualTo: "$query\uf7ff") 
        .get();
    }


    for (var rawuser in result.docs) {
      data = rawuser.data() as Map<String, dynamic>;
      users.add(
        new UserModel.apiStorage(
          uid: data['uid'], 
          email: data['email'], 
          emailVisible: data['emailvisible'], 
          displayName: data['username'], 
          userColor: data['usercolor'],
        ),
      );
    }

    return users;
  }
}