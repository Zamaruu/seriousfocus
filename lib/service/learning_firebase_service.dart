import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';

class LearningService {
  late String _uid;
  String get uid => _uid;
  final String _collection = "FlashCards";

  LearningService(){
    _uid = FirebaseAuth.instance.currentUser!.uid;
  }

  //Methods
  //Category methods
  Future<List<LearningCategoryModel>> getAllCategories() async{
    //Variables
    List<LearningCategoryModel> categories = <LearningCategoryModel>[];
    late Map<String, dynamic> data;
    
    //Get all categories
    QuerySnapshot result = await FirebaseFirestore.instance.collection(_collection).doc(_uid).collection("myCategories").get();
    
    for (DocumentSnapshot doc in result.docs) {
      data = doc.data() as Map<String, dynamic>;
      categories.add(
        new LearningCategoryModel.formFirebase(
          doc.id, 
          0, 
          new Color(data['color']), 
          data['name'],
        ),
      );
    }

    return categories;
  }

  createNewCategory(LearningCategoryModel model) async{
    var res = await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection("myCategories")
      .add(model.toMap());
    print(res);
  }

  editCategory(LearningCategoryModel model) async {
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection("myCategories")
      .doc(model.documentID)
      .update(model.toMap());
  }

  Future deleteCategory(String categoryID) async{
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection("myCategories")
      .doc(categoryID)
      .delete();
  }

  //Flipcard methods
  Future<List<LearningFlashcardModel>> getAllFlashcardsForCategory(String categoryID) async {
    List<LearningFlashcardModel> cards = <LearningFlashcardModel>[];
    late Map<String, dynamic> flashcard;
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection(_collection)
        .doc(_uid)
        .collection("myFlashcards")
        .where("categoryid", isEqualTo: categoryID.trim())
        .get();

    for (DocumentSnapshot doc in result.docs) {
      flashcard = doc.data() as Map<String, dynamic>;
      flashcard["id"] = doc.id;
      cards.add(
        new LearningFlashcardModel.fromJson(flashcard),
      );
    }

    return cards;
  }

  Future<void> createNewFlashcard(LearningFlashcardModel model) async{
    var res = await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection("myFlashcards")
      .add(model.toMap());
    print(res);
  }

  editFlashcard(){

  }

  Future<void> deleteFlashcard(String flashcardID) async {
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection("myFlashcards")
      .doc(flashcardID)
      .delete();
  }

  moveFlashcardsToOtherCategory(){

  }

  setlFashcardsLearningValues(){

  }
}