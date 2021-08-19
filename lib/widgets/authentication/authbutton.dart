import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final Function? onPressed;
  final double height;
  final EdgeInsets? margin;
  final String text;
  final IconData icon;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const AuthButton({
    Key? key, 
    this.onPressed, 
    required this.text, 
    required this.icon, 
    this.foregroundColor = Colors.white, 
    this.backgroundColor, 
    this.margin = const EdgeInsets.only(top: 15), 
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: double.maxFinite,
      child: ElevatedButton.icon(
        onPressed: onPressed != null?
          () => onPressed!(): null, 
        icon: FaIcon(icon, color: foregroundColor,), 
        label: Text(text, style: TextStyle(color: foregroundColor),),
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
        ),
      ),
    );
  }
}