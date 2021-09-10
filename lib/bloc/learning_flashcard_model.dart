import 'package:flutter/material.dart';

class LearningFlashcardModel {
  String? _documentID;
  String? get documentID => _documentID;
  String? _categoryID;
  String? get categoryID => _categoryID;
  late String _question;
  String get question => _question;
  late String _answer;
  String get answer => _answer;
  late int? _status;
  int? get status => _status;

  //Constructor
  LearningFlashcardModel.edit(
    this._documentID,
    this._question,
    this._answer,
    this._categoryID,
    this._status,
  );

  LearningFlashcardModel.formFirebase(
    this._documentID,
    this._categoryID,
    this._answer,
    this._question,
    this._status,
  );

  LearningFlashcardModel.fromJson(Map<String, dynamic> json) {
    this._documentID = json['id'];
    this._categoryID = json['categoryid'];
    this._question = json['question'];
    this._answer = json['answer'];
    this._status = json['status'];
  }

  //Methods
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryid': _categoryID!.trim(),
      'question': _question.trim(),
      'answer': _answer.trim(),
      'status': _status,
    };
  }
}
