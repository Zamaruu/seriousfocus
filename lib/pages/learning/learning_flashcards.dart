import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:seriousfocus/widgets/learning/learning_flashcard_card.dart';
import 'package:seriousfocus/widgets/learning/learning_flipcard.dart';

// ignore: must_be_immutable
class LearningFlashcards extends StatelessWidget {
  final String categoryName;
  final List<LearningFlashcardModel> flashcards;
  final LearningFlashcardModel initialFlashCard;
  late int initialFlashcardIndex;
  late PageController _pageController;

  LearningFlashcards({
    Key? key, 
    required this.categoryName, 
    required this.flashcards, 
    required this.initialFlashCard,
  }) : super(key: key){
    initialFlashcardIndex = flashcards.indexOf(initialFlashCard); 
    LearningFlashcardModel firstFlashcard = flashcards.removeAt(initialFlashcardIndex);
    flashcards.insert(0, firstFlashcard);

    _pageController = new PageController(
      initialPage: 0,
    );
  }

  //Methods

  //Widgets
  _bodyList(){
    return PageView.builder(
      controller: _pageController,
      itemCount: flashcards.length,
      itemBuilder: (context, index){
        return LearningFlipcard(model: flashcards[index]);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: categoryName,
      body: _bodyList(),
      bottomNavigationBar: Container(
        height: 55,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}