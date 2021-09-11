import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/globals.dart';

class LearningcategoryMenu extends StatelessWidget {
  final Function onNewPressed;

  const LearningcategoryMenu({Key? key, required this.onNewPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      alignment: Alignment.bottomRight,
      curve: Curves.easeInOutBack,
      toggleButtonColor: Theme.of(context).primaryColor,
      toggleButtonBoxShadow: [
        BoxShadow(
          blurRadius: 0,
          spreadRadius: 0.0
        ),
      ],
      radius: 115,
      toggleButtonIconColor: Colors.white,
      toggleButtonMargin: 5.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 40.0,
      items: [
        CircularMenuItem(
          boxShadow: [
            BoxShadow(blurRadius: 0, spreadRadius: 0.0),
          ],
          icon: Icons.edit,
          onTap: () {
          },
        ),
        CircularMenuItem(
          boxShadow: [
            BoxShadow(blurRadius: 0, spreadRadius: 0.0),
          ],
          icon: Icons.delete,
          onTap: () {
          },
        ),
        CircularMenuItem(
          boxShadow: [
            BoxShadow(blurRadius: 0, spreadRadius: 0.0),
          ],
          icon: Icons.add,
          onTap: () => onNewPressed(),
        ),
        CircularMenuItem(
          boxShadow: [
            BoxShadow(blurRadius: 0, spreadRadius: 0.0),
          ],
          icon: Icons.school,
          onTap: () {
          },
        ),
      ]
    );
  }
}