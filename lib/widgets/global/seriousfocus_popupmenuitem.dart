import 'package:flutter/material.dart';

class SeriousFocusPopup {
  PopupMenuItem actionItem(BuildContext context, int value,
      {required String title,
      required IconData icon,}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Container(
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }
}