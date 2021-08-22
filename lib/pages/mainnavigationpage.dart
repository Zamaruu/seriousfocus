import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/pages/forum/forumpage.dart';
import 'package:seriousfocus/pages/home/homepage.dart';
import 'package:seriousfocus/pages/learning/learningpage.dart';
import 'package:seriousfocus/pages/tasks/taskpage.dart';
import 'package:seriousfocus/pages/user/userpage.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class SeriousFocusMainNavigationPage extends StatefulWidget {
  const SeriousFocusMainNavigationPage({ Key? key }) : super(key: key);

  @override
  _SeriousFocusMainNavigationPageState createState() => _SeriousFocusMainNavigationPageState();
}

class _SeriousFocusMainNavigationPageState extends State<SeriousFocusMainNavigationPage> {
  late int _pageindex;
  final Color iconColor = Colors.white;
  final double iconSize = 30.0;

  @override
  void initState() {
    super.initState();
    _pageindex = 2;
  }

  final List<Widget> _mainpages = [
    Homepage(),
    Forumpage(),
    Learningpage(),
    Taskpage(),
    Userpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      body: _mainpages[_pageindex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageindex,
        color: Colors.purple,
        backgroundColor: Colors.white,
        items: <Icon>[
          Icon(Icons.home, size: iconSize, color: iconColor,),
          Icon(Icons.forum, size: iconSize, color: iconColor,),
          Icon(Icons.dashboard_rounded, size: iconSize, color: iconColor,),
          Icon(Icons.checklist, size: iconSize, color: iconColor,),
          Icon(Icons.person, size: iconSize, color: iconColor,),
        ],
        onTap: (index) {
          setState(() {
            _pageindex = index;
          });
        },
      ),
    );
  }
}