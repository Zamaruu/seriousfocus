import 'package:flutter/material.dart';
import 'package:seriousfocus/pages/user/find_user_page.dart';
import 'package:seriousfocus/pages/user/userpage.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class MainUserPage extends StatelessWidget {
  const MainUserPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: SeriousFocusScaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.person_search)),
            ],
          ),
          title: const Text('Benutzer'),
        ),
        body: TabBarView(
          children: [
            Userpage(),
            FindUserPage(),
          ],
        ),
      ),
    );
  }
}