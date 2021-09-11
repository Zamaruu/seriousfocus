import 'package:flutter/material.dart';

class LearningEditingModel extends ChangeNotifier {
  late List<String> _selectedFlashcards;
  List<String> get selectedFlashcards => _selectedFlashcards;

  LearningEditingModel(this._selectedFlashcards);

  void addFlashcardToList(String flashcardID){
    if(!_selectedFlashcards.contains(flashcardID))
      _selectedFlashcards = [flashcardID, ..._selectedFlashcards];
    print(_selectedFlashcards);
    notifyListeners();
  }

  void removeFlashcardFromList(String flashcardID){
    if (_selectedFlashcards.contains(flashcardID))
      _selectedFlashcards.remove(flashcardID);
    print(_selectedFlashcards);
    notifyListeners();
  }

  void resetSelectedFlashcards(){
    _selectedFlashcards = [];
    notifyListeners();
  }
}