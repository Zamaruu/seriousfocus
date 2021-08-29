import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDataTile extends StatelessWidget {
  final EdgeInsets margin;
  late IconData icon;
  late String title;
  final Function onTap;
  final String userTileType;
  late Color userColor;

  UserDataTile({ 
    Key? key, 
    this.margin = const EdgeInsets.all(0), 
    required this.icon, 
    required this.title, 
    required this.onTap, 
    this.userTileType = "normal", 
  }) : super(key: key);

  UserDataTile.color({
    this.margin = const EdgeInsets.all(0), 
    required this.onTap, 
    this.userTileType = "color", 
    required this.userColor
  });

  //Widgets
  Container _normal(BuildContext context){
    return Container(
      margin: margin,
      child: ListTile(
        leading: FaIcon(icon, color: Theme.of(context).primaryColor,),
        title: Text(title),
        onTap: () => onTap(),
      ),
    );
  }

  Container _color(BuildContext context) {
    return Container(
      margin: margin,
      child: ListTile(
        leading: CircleAvatar(
          radius:  15,
          backgroundColor: userColor,
        ),
        title: Text("Deine Anzeigefarbe"),
        onTap: () => onTap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (userTileType) {
      case "normal":
        return _normal(context);
      case "color":
        return _color(context);
      default:
        return _normal(context);
    }
  }
}