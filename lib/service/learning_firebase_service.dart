import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';

class LearningService {
  late String _uid;
  String get uid => _uid;
  final String _collection = "FlashCards";
  // ignore: non_constant_identifier_names
  final String MY_CATEGORIES = "myCategories";
  // ignore: non_constant_identifier_names
  final String MY_FLASHCARDS = "myFlashcards";

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
    QuerySnapshot result = await FirebaseFirestore.instance.collection(_collection).doc(_uid).collection(MY_CATEGORIES).get();
    
    for (DocumentSnapshot doc in result.docs) {
      data = doc.data() as Map<String, dynamic>;
      categories.add(
        new LearningCategoryModel.formFirebase(
          doc.id, 
          await countFlashcardsForCategory(doc.id), 
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
      .collection(MY_CATEGORIES)
      .add(model.toMap());
    print(res);
  }

  editCategory(LearningCategoryModel model) async {
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_CATEGORIES)
      .doc(model.documentID)
      .update(model.toMap());
  }

  Future deleteCategory(String categoryID) async{
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_CATEGORIES)
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
        .collection(MY_FLASHCARDS)
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

  Future<int> countFlashcardsForCategory(String categoryID) async {
    QuerySnapshot result = await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_FLASHCARDS)
      .where("categoryid", isEqualTo: categoryID.trim())
      .get();

    return result.size;
  }

  Future<void> createNewFlashcard(LearningFlashcardModel model) async{
    var res = await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_FLASHCARDS)
      .add(model.toMap());
    print(res);
  }

  editFlashcard(){

  }

  Future<void> deleteFlashcard(List<String> flashcardIDs) async {
    for (String id in flashcardIDs) {
      await FirebaseFirestore.instance
        .collection(_collection)
        .doc(_uid)
        .collection(MY_FLASHCARDS)
        .doc(id)
        .delete();
    }
  }

  Future<void> moveFlashcardsToOtherCategory(List<String> flashcardIDs, String categoryID) async {
    for (String id in flashcardIDs) {
      await FirebaseFirestore.instance
        .collection(_collection)
        .doc(_uid)
        .collection(MY_FLASHCARDS)
        .doc(id)
        .update({
          "categoryid": categoryID,
        });
    }
  }

  Future<LearningFlashcardModel> setFashcardsLearningStatus(String documentID, int newStatus) async {
    await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_FLASHCARDS)
      .doc(documentID)
      .update({
        "status": newStatus,
      });

    var updatedRawResult = await FirebaseFirestore.instance
      .collection(_collection)
      .doc(_uid)
      .collection(MY_FLASHCARDS)
      .doc(documentID)
      .get();
    
    var rawJson = updatedRawResult.data() as Map<String, dynamic>;
    rawJson["id"] = updatedRawResult.id;

    return LearningFlashcardModel.fromJson(rawJson);
  }
}