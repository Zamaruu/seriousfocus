import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/bloc/learning_category_editing_model.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/pages/learning/add_flashcard_partial.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_popupmenuitem.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:seriousfocus/widgets/learning/learning_category_fab.dart';
import 'package:seriousfocus/widgets/learning/learning_flashcard_card.dart';
import 'package:seriousfocus/widgets/learning/learning_flipcard.dart';
import 'package:seriousfocus/widgets/learning/learning_move_to_category.dart';
import 'package:side_sheet/side_sheet.dart';


class LearningStateparent extends StatelessWidget {
  final LearningCategoryModel model;
  
  const LearningStateparent({ Key? key, required this.model }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LearningEditingModel(<String>[]),
      child: LearningCategoryPage(model: model,),
    );
  }
}

class LearningCategoryPage extends StatefulWidget {
  final LearningCategoryModel model;

  const LearningCategoryPage({Key? key, required this.model}) : super(key: key);

  @override
  _LearningCategoryPageState createState() => _LearningCategoryPageState();
}

class _LearningCategoryPageState extends State<LearningCategoryPage> {
  
  //Methods
  Future<void> _refreshPage() async {
    setState(() {
      
    });
  }

  void _newFlashcard(BuildContext context){
    SideSheet.right(
      context: context,
      body: AddFlashCardPage(
        refreshCallback: _refreshPage,
        categoryID: widget.model.documentID!,
      ),
    );
  }

  //Widgtes
  GridView _listBody(List<LearningFlashcardModel> flashcards){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: flashcards.length,
      itemBuilder: (BuildContext context, int index) {
        return LearningFlashcardCard(
          model: flashcards[index], 
          categoryColor: widget.model.categoryColor,
          refreshCallback: _refreshPage,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LearningFlipcard(model: flashcards[index])
            )
          ),
        );
      },
    );
  }

  Widget _body(){
    return FutureBuilder<List<LearningFlashcardModel>>(
      future: LearningService().getAllFlashcardsForCategory(widget.model.documentID!),
      builder: (BuildContext context, AsyncSnapshot<List<LearningFlashcardModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else{
          if(snapshot.data!.isEmpty){
            return Center(
              child: Text("Keine Karteikarten in ${widget.model.name} vorhanden."),
            ); 
          }
          else{
            return _listBody(snapshot.data!);
          }
        }
      },
    );
  }

  List<Widget> _actions(BuildContext context){
    return <Widget>[
      Consumer<LearningEditingModel>(
        builder: (context, model, _){
          return Visibility(
            visible: model.selectedFlashcards.length >= 1,
            child: PopupMenuButton(
              tooltip: "Optionen",
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext ctx) => <PopupMenuEntry>[
                SeriousFocusPopup().actionItem(
                  context,
                  title: "Verschieben",
                  icon: Icons.move_to_inbox,
                  onTap: () => LearningMoveToCategory(ctx).moveToCategory(model.selectedFlashcards, _refreshPage),
                ),
                SeriousFocusPopup().actionItem(
                  context,
                  title: "Löschen",
                  icon: Icons.delete,
                  onTap: () async {
                    await LearningService().deleteFlashcard(model.selectedFlashcards);
                    model.resetSelectedFlashcards();
                    _refreshPage();
                  },
                ),
              ],
            ),
          );
        }
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      title: widget.model.name,
      showAppBar: true,
      body: _body(),
      actions: _actions(context),
      fab: LearningcategoryMenu(
        onNewPressed: () => _newFlashcard(context),
      ),
    );
  }
}