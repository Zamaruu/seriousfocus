import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'dart:math' as math;

class LearningFlipcard extends StatelessWidget {
  final LearningFlashcardModel model;
  final double iconSize;

  const LearningFlipcard({ Key? key, required this.model, this.iconSize = 30.0}) : super(key: key);

  FaIcon _getIconBasedOnStatus(){
    switch (model.status) {
      case 1:
        return FaIcon(
          FontAwesomeIcons.frown, 
          color: Colors.red, 
          size: iconSize,
        );
      case 2:
        return FaIcon(
          FontAwesomeIcons.meh, 
          color: Colors.yellow[700],
          size: iconSize,
        );
      case 3:
        return FaIcon(
          FontAwesomeIcons.smileBeam, 
          color: Colors.green,
          size: iconSize,
        );
      default:
        return FaIcon(
          FontAwesomeIcons.meh,
          color: Colors.grey,
          size: iconSize,
        );
    }
  }

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
            offset: Offset(0, -0.5),
          ),
        ],
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: Html(
              data: content
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 6,
            child: _getIconBasedOnStatus(),
          ),
        ],
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
            front: _body(Global.quillDocumentJsonToHtml(model.question), context), 
            back: _body(Global.quillDocumentJsonToHtml(model.answer), context), 
          ),
        ),
      ),
    );
  }
}