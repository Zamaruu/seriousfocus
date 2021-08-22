import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeriousFocusButton extends StatelessWidget {
  final double borderRadius;
  final EdgeInsets margin;
  final IconData icon;
  final String text;
  Color contentColor;
  final Color backgoundColor;
  final Function? onPressed;

  SeriousFocusButton({
    Key? key, 
    required this.icon, 
    required this.text, 
    this.backgoundColor = Colors.purple, 
    this.onPressed, 
    this.contentColor = Colors.white, 
    this.borderRadius = 20.0, 
    this.margin = const EdgeInsets.all(0), 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contentColor = backgoundColor.computeLuminance() > 0.5 ? Colors.black: Colors.white;
    return Container(
      margin: margin,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: backgoundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed != null?
          () => onPressed!(): null, 
        icon: FaIcon(icon, color: contentColor,), 
        label: Text(text, style: TextStyle(color: contentColor),),
      ),
    );
  }
}