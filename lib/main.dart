import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seriousfocus/pages/mainnavigationpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      home: SeriousFocusMainNavigationPage(),
    );
  }
}
