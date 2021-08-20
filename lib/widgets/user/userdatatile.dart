import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDataTile extends StatelessWidget {
  final EdgeInsets margin;
  final IconData icon;
  final String title;
  final Function onTap;

  const UserDataTile({ 
    Key? key, 
    this.margin = const EdgeInsets.all(0), 
    required this.icon, 
    required this.title, 
    required this.onTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ListTile(
        leading: FaIcon(icon, color: Theme.of(context).primaryColor,),
        title: Text(title),
        onTap: () => onTap(),
      ),
    );
  }
}