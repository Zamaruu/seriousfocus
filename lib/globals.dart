

import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_textbutton.dart';

class Global {
  static double appPadding = 15;
  static double appMargin = 15;
  static double splashRadius = 22.5;
  static double borderRadius = 10.0;
  static double listviewBottomSpace = 50.0;

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