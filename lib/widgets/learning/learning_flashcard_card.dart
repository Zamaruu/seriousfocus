import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/bloc/learning_category_editing_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';

class LearningFlashcardCard extends StatelessWidget {
  final LearningFlashcardModel model;
  final Color categoryColor;
  final double height;
  final Function refreshCallback;

  const LearningFlashcardCard({
    Key? key,
    required this.model, 
    required this.categoryColor, 
    required this.refreshCallback,
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
  PopupMenuItem _actionItem(BuildContext context, {required String title, required IconData icon, required Function onTap}){
    return PopupMenuItem(
      child: GestureDetector(
        onTap: () async {
          await onTap();
          refreshCallback();
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
            SizedBox(width: 10,),
            Text(title),
          ],
        ),
      ),
    );
  }

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
            _actionItem(
              context, 
              title: "Bearbeiten", 
              icon: Icons.edit, 
              onTap: (){},
            ),
            _actionItem(
              context,
              title: "Verschieben",
              icon: Icons.move_to_inbox,
              onTap: () {},
            ),
            _actionItem(
              context,
              title: "Löschen",
              icon: Icons.delete,
              onTap: () => LearningService().deleteFlashcard(model.documentID!),
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
          onTap: (){},
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