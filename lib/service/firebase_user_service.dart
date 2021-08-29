import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}