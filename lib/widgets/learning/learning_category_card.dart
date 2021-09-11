import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/learning/edit_category_partial.dart';
import 'package:seriousfocus/pages/learning/learning_category_page.dart';
import 'package:side_sheet/side_sheet.dart';

class LearningCategoryCard extends StatelessWidget {
  final double height;
  final Function? onPressed;
  final Function refreshCallback;
  final LearningCategoryModel model;

  LearningCategoryCard(
      {Key? key,
      this.height = 154.0,
      this.onPressed,
      required this.model,
      required this.refreshCallback})
      : super(key: key);

  //Methods
  Future<void> _deleteCategory(BuildContext context) {
    return Global.seriousFocusAlert(
      context,
      onPressed: () async {
        await LearningService().deleteCategory(model.documentID!);
        refreshCallback();
        Navigator.of(context).pop();
      },
      title: "Kategorie löschen",
      content: "Wollen Sie die Kategorie\n'${model.name}' wirklich löschen?",
      onPressedText: "Kategorie löschen",
    );
  }

  void _editCategory(BuildContext context) {
    SideSheet.right(
      context: context,
      body: EditCategoryPartial(refreshCallback: refreshCallback, model: model),
    );
    // showBottomSheet(
    //   context: context,
    //   builder: (BuildContext context){
    //     return EditCategoryPartial(
    //       refreshCallback: refreshCallback,
    //       model: model
    //     );
    //   }
    // );
  }

  void _navigateToCategory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearningStateparent(model: model),
      ),
    );
  }

  //Widgets
  //TODO: https://stackoverflow.com/questions/61289182/how-to-get-first-character-from-words-in-flutter-dart
  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: model.categoryColor,
          child: Text(
            model.name.trim()[0].toUpperCase(),
            style: TextStyle(
                color: model.categoryColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: Global.appMargin),
          child: Text(
            model.name,
            style: TextStyle(
                color: model.categoryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
      ],
    );
  }

  Row _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _deleteCategory(context),
          icon: FaIcon(Icons.delete),
          splashRadius: Global.splashRadius,
          color: Colors.purple,
        ),
        IconButton(
          onPressed: () => _editCategory(context),
          icon: FaIcon(Icons.edit),
          splashRadius: Global.splashRadius,
          color: Colors.purple,
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.graduationCap),
          splashRadius: Global.splashRadius,
          color: Colors.purple,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Global.appMargin,
        top: Global.appMargin,
        right: Global.appMargin,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Global.borderRadius / 2),
        elevation: 4,
        child: InkWell(
          onTap: () => _navigateToCategory(context),
          splashColor: model.categoryColor.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Global.borderRadius / 2),
            ),
            height: height,
            padding: EdgeInsets.only(
              left: Global.appPadding,
              right: Global.appPadding,
              top: Global.appPadding,
              bottom: Global.appPadding / 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                Container(
                  margin: EdgeInsets.only(top: Global.appMargin),
                  child: RichText(
                    text: TextSpan(
                      text: model.childrenCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Elemente in diesem Gebiet!',
                            style: DefaultTextStyle.of(context).style),
                      ],
                    ),
                  ),
                  //child: Text("${categoryData.childrenCount} Elemente in diesem Gebiet!"),
                ),
                Spacer(),
                _actions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
