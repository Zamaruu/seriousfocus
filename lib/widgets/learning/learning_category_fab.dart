import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/globals.dart';

class LearningcategoryMenu extends StatelessWidget {
  const LearningcategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      alignment: Alignment.bottomRight,
      toggleButtonColor: Theme.of(context).primaryColor,
      radius: 115,
      toggleButtonIconColor: Colors.white,
      toggleButtonMargin: 5.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 40.0,
      items: [
        CircularMenuItem(
          icon: Icons.edit,
          onTap: () {
            //callback
          },
        ),
        CircularMenuItem(
          icon: Icons.delete,
          onTap: () {
            //callback
          },
        ),
        CircularMenuItem(
          icon: Icons.add,
          onTap: () {
            //callback
          },
        ),
        CircularMenuItem(
          icon: Icons.school,
          onTap: () {
            //callback
          },
        ),
      ]
    );
  }
}