import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeriousFocusTextButton extends StatelessWidget {
  final double borderRadius;
  final EdgeInsets margin;
  final IconData icon;
  final String text;
  Color contentColor;
  final Color backgoundColor;
  final Function? onPressed;

  SeriousFocusTextButton({
    Key? key,
    required this.icon,
    required this.text,
    this.backgoundColor = Colors.purple,
    this.onPressed,
    this.contentColor = Colors.purple,
    this.borderRadius = 20.0,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          primary: backgoundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed != null ? () => onPressed!() : null,
        icon: FaIcon(
          icon,
          color: contentColor,
        ),
        label: Text(
          text,
          style: TextStyle(color: contentColor),
        ),
      ),
    );
  }
}
