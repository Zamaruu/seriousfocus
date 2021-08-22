import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/learning/add_category_page.dart';
import 'package:seriousfocus/pages/learning/learning_category_card.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class Learningpage extends StatelessWidget {
  Learningpage({Key? key}) : super(key: key);

  //Methods
  void createNewCategory(BuildContext context){
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
        splashRadius: Global.splashRadius,
      ),
    ];
  }

  Material _body(){
    return Material(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.only(bottom: Global.appPadding * 2),
        itemBuilder: (context, index){
          return LearningCategoryCard(
            categoryData: new LearningCategoryModel(
              Colors.blue, 
              "Gebiet $index", 
              Random().nextInt(40) + 10,
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Karteikarten",
      actions: _actions(context),
      body: _body(),
    );
  }
}
