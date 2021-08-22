import 'package:flutter/material.dart';

class SeriousFocusAppBar extends StatelessWidget  {
  final String title;
  final List<Widget>? actions;

  const SeriousFocusAppBar({Key? key, required this.title, this.actions}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      ),
      backgroundColor: Colors.white,
      actions: actions,
      elevation: 0,
    );
  }
}