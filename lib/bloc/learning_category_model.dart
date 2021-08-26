import 'package:flutter/material.dart';

class LearningCategoryModel {
  String? _documentID;
  String? get documentID => _documentID;
  final Color _categoryColor;
  Color get categoryColor => _categoryColor;
  final String _name;
  String get name => _name;
  int? _childrenCount;
  int? get childrenCount => _childrenCount;

  //Constructor
  LearningCategoryModel(this._categoryColor, this._name);

  LearningCategoryModel.formFirebase(
    this._documentID,
    this._childrenCount,
    this._categoryColor, 
    this._name,
  );

  //Methods
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': _name.trim(),
      'color': _categoryColor.value,
    };
  }
}