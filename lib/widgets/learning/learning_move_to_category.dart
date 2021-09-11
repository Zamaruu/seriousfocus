import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_editing_model.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:provider/provider.dart';

class LearningMoveToCategory {
  final BuildContext ctx;

  LearningMoveToCategory(this.ctx) {
    //_categories = await
  }

  void moveToCategory(List<String> selectedFlashcards, Function refreshCallback) {
    showBottomSheet(
      context: ctx,
      builder: (context) {
        return Material(
          //height: 200,
          color: Colors.grey[100],
          child: FutureBuilder<List<LearningCategoryModel>>(
            future: LearningService().getAllCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<LearningCategoryModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: 200,
                  child: Center(
                    child: Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                return Wrap(
                  children: [
                    Container(
                      height: 15,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Container(
                          height: 7.5,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        LearningCategoryModel model = snapshot.data![index];
                        return ListTile(
                          onTap: () async {
                            await LearningService().moveFlashcardsToOtherCategory(selectedFlashcards, model.documentID!);
                            Navigator.of(context).pop();
                            refreshCallback();
                          },
                          title: Text(model.name),
                          subtitle: Text("${model.childrenCount} Karteikarten"),
                        );
                      }
                    )
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}
