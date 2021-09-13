import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class LearningFlipcard extends StatelessWidget {
  final LearningFlashcardModel model;
  const LearningFlipcard({ Key? key, required this.model }) : super(key: key);

  Container _body(String content, BuildContext context){
    return Container(
      padding: EdgeInsets.all(Global.appPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
            front: _body(model.question, context), 
            back: _body(model.answer, context), 
          ),
        ),
      ),
    );
  }
}