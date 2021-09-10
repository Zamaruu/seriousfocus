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
      radius: 115,
      toggleButtonIconColor: Colors.white,
      toggleButtonMargin: 5.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 40.0,
      items: [
        CircularMenuItem(
          icon: Icons.edit,
          onTap: () {
          },
        ),
        CircularMenuItem(
          icon: Icons.delete,
          onTap: () {
          },
        ),
        CircularMenuItem(
          icon: Icons.add,
          onTap: () => onNewPressed(),
        ),
        CircularMenuItem(
          icon: Icons.school,
          onTap: () {
          },
        ),
      ]
    );
  }
}