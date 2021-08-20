import 'package:flutter/material.dart';

class SeriousFocusAppBar extends StatelessWidget  {
  final String title;
  
  const SeriousFocusAppBar({Key? key, required this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}