import 'package:flutter/material.dart';

class SeriousFocusUserAvatar extends StatelessWidget {
  final double radius;
  final String userDisplayName;
  final Color backgroundColor;
  late List<String> _displayNameSplit;
  late String _initials;

  SeriousFocusUserAvatar({ 
    Key? key, 
    this.radius = 300.0, 
    required this.userDisplayName, 
    required this.backgroundColor,
  }) : super(key: key){
    _displayNameSplit = userDisplayName.split(" ");
    _displayNameSplit.length >= 2?
      _initials = _displayNameSplit[0][0].toUpperCase() + _displayNameSplit[1][0].toUpperCase() 
      : _initials = _displayNameSplit[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor
      ),
      child: FittedBox(
        child: Center(
          child: Text(
            _initials,
            style: TextStyle(
              color: backgroundColor.computeLuminance() > 0.5 ? Colors.black: Colors.white, 
            ),
          ),
        ),
      ),
      
    );
  }
}