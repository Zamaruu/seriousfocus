import 'package:flutter/material.dart';

class LearningCategoryModel {
  final Color _categoryColor;
  Color get categoryColor => _categoryColor;
  final String _name;
  String get name => _name;
  final int _childrenCount;
  int get childrenCount => _childrenCount;

  //Constructor
  LearningCategoryModel(this._categoryColor, this._name, this._childrenCount);
}