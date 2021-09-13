import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/bloc/learning_category_editing_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_popupmenuitem.dart';

import 'learning_move_to_category.dart';

class LearningFlashcardCard extends StatelessWidget {
  final LearningFlashcardModel model;
  final Color categoryColor;
  final double height;
  final Function refreshCallback;
  final Function onTap;

  const LearningFlashcardCard({
    Key? key,
    required this.model, 
    required this.categoryColor, 
    required this.refreshCallback,
    required this.onTap,
    this.height = 200.0, 
  }) : super(key: key);

  //Methods
  Color _getStatusColor(int status){
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  //Widgtes

  Row _actions(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<LearningEditingModel>(
          builder: (context, editingModel, _) {
            return Checkbox(
              value: editingModel.selectedFlashcards.contains(model.documentID!.trim()), 
              onChanged: (checked){
                if(editingModel.selectedFlashcards.contains(model.documentID))
                  editingModel.removeFlashcardFromList(model.documentID!);
                else
                  editingModel.addFlashcardToList(model.documentID!);
              }
            );
          }
        ),
        Spacer(),
        PopupMenuButton(
          tooltip: "Optionen",
          icon: Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            SeriousFocusPopup().actionItem(
              context, 
              title: "Bearbeiten", 
              icon: Icons.edit, 
              onTap: (){},
            ),
            SeriousFocusPopup().actionItem(
              context,
              title: "Verschieben",
              icon: Icons.move_to_inbox,
               onTap: () => LearningMoveToCategory(context).moveToCategory([model.documentID!], refreshCallback),
            ),
            SeriousFocusPopup().actionItem(
              context,
              title: "Löschen",
              icon: Icons.delete,
              onTap: () => LearningService().deleteFlashcard([model.documentID!]),
            ),
          ],
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
          onTap: () => onTap(),
          splashColor: categoryColor.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Global.borderRadius / 2),
            ),
            height: height,
            // padding: EdgeInsets.only(
            //   left: Global.appPadding,
            //   right: Global.appPadding,
            //   top: Global.appPadding,
            //   bottom: Global.appPadding / 2,
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height - 20,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          model.question,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _actions(context),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Global.borderRadius / 2),
                      bottomRight: Radius.circular(Global.borderRadius / 2),
                    ),
                    color: _getStatusColor(model.status!)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}