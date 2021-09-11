import 'package:flutter/material.dart';

class SeriousFocusPopup {
  PopupMenuItem actionItem(BuildContext context,
      {required String title,
      required IconData icon,
      required Function onTap}) {
    return PopupMenuItem(
      child: GestureDetector(
        onTap: () async {
          await onTap();
          Navigator.of(context).pop();
        },
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
      ),
    );
  }
}