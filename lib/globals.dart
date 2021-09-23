

import 'dart:convert';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:flutter_quill/models/quill_delta.dart';
import 'package:markdown/markdown.dart' as Markdown;
import 'package:seriousfocus/widgets/global/seriousfocus_textbutton.dart';

class Global {
  static double appPadding = 15;
  static double appMargin = 15;
  static double splashRadius = 22.5;
  static double borderRadius = 10.0;
  static double listviewBottomSpace = 50.0;

  static String quillDocumentJsonToHtml(String deltajson) {
    Delta delta = Quill.Document.fromJson(jsonDecode(deltajson)).toDelta();
    final convertedValue = jsonEncode(delta);
    final markdown = deltaToMarkdown(convertedValue);
    final html = Markdown.markdownToHtml(markdown);

    return html;
  }

  static Future<void> seriousFocusAlert(BuildContext context, {required Function onPressed, required String title, required String content, required String onPressedText, bool success = false}){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
            title: Text(title,),
            content: Container(
              child: Text(content,),
            ),
            actions: <Widget>[
              SeriousFocusTextButton(
                icon: Icons.arrow_back,
                text: "Abbrechen",
                onPressed: () => Navigator.of(context).pop(),
              ),
              SeriousFocusTextButton(
                icon: success? Icons.done: Icons.delete,
                backgoundColor:  success? Colors.green: Colors.red,
                contentColor: success? Colors.green: Colors.red,
                text: onPressedText,
                onPressed: onPressed,
              ),
            ],
          );
      }
    );
  }
}