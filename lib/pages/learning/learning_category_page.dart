import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:seriousfocus/widgets/learning/learning_category_fab.dart';

class LearningCategoryPage extends StatelessWidget {
  final LearningCategoryModel model;
  
  const LearningCategoryPage({Key? key, required this.model}) : super(key: key);

  //Methods

  //Widgets
  Widget _body(){
    return FutureBuilder(
      future: LearningService().getAllFlipCardsForCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      title: model.name,
      showAppBar: true,
      body: _body(),
      fab: LearningcategoryMenu(),
    );
  }
}