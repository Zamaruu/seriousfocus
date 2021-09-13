import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class LearningFlipcard extends StatelessWidget {
  final LearningFlashcardModel model;
  const LearningFlipcard({ Key? key, required this.model }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                model.question,
                textAlign: TextAlign.center,
              ),
            ),
            back: Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                model.answer,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}