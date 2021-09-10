import 'package:flutter/material.dart';

class LearningEditingModel extends ChangeNotifier {
  late List<String> _selectedFlashcards;
  List<String> get selectedFlashcards => _selectedFlashcards;

  LearningEditingModel(this._selectedFlashcards);

  void addFlashcardToList(String flashcardID){
    if(!_selectedFlashcards.contains(flashcardID))
      _selectedFlashcards.add(flashcardID);
    notifyListeners();
  }

  void removeFlashcardFromList(String flashcardID){
    if (_selectedFlashcards.contains(flashcardID))
      _selectedFlashcards.remove(flashcardID);
    notifyListeners();
  }
}