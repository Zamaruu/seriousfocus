import 'package:flutter/material.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/learning/add_category_page.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class Learningpage extends StatelessWidget {
  Learningpage({Key? key}) : super(key: key);

  

  //Methods
  void createNewCategory(BuildContext context){
    showBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return AddCategoryPage();
      }
    );
  }

  //Widgtes
  List<Widget> _actions(BuildContext context) {
    return <IconButton>[
      IconButton(
        onPressed: () => createNewCategory(context),
        icon: Icon(Icons.add),
        color: Colors.purple,
        splashRadius: Global().splashRadius,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Karteikarten",
      actions: _actions(context),
    );
  }
}
