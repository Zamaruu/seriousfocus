import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditFlashcardPage extends StatefulWidget {
  final Function refreshCallback;
  final String categoryID;

  const EditFlashcardPage({ Key? key, required this.refreshCallback, required this.categoryID }) : super(key: key);

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {
  late Quill.QuillController _questionController = Quill.QuillController.basic();
  late Quill.QuillController _answerController = Quill.QuillController.basic();

  //Methods
  void _saveFlashcard(){
    if(_questionController.document.isEmpty() || _answerController.document.isEmpty()){
      showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: "Frage oder Antwort ist nicht gefüllt, überprüfe das!",
        ),
      );
    }
    else{
      LearningService().createNewFlashcard(
        new LearningFlashcardModel.edit(
          "",
          jsonEncode(_questionController.document.toDelta().toJson()),
          jsonEncode(_answerController.document.toDelta().toJson()),
          widget.categoryID,
          0,
        ),
      );
      widget.refreshCallback();
      Navigator.of(context).pop();
    }
  }

  //Widgtes
  TabBar _tabBar(){
    return TabBar(
      onTap: (index){
        FocusManager.instance.primaryFocus?.unfocus();
        },
      tabs: <Tab>[
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.question, color: Theme.of(context).primaryColor, size: 15,),
              SizedBox(width: 10,),
              Text("Frage", style: TextStyle(color: Theme.of(context).primaryColor),)
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.checkCircle,
                color: Theme.of(context).primaryColor,
                size: 19,
              ),
                SizedBox(
                width: 10,
              ),
              Text(
                "Antwort",
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ]
    );
  }

  ListView _tabBody(Quill.QuillController controller){
    double margin = 20.0;
    return ListView(
      children: [
        Quill.QuillToolbar.basic(
          controller: controller,
          showBackgroundColorButton: false,
          showCameraButton: false,
          showColorButton: false,
          showImageButton: false,
          showQuote: false,
          showHistory: false,
          showVideoButton: false,
          showLink: false,
          showListCheck: false,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.45
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 5
                ),
              ],
            ),
            margin: EdgeInsets.only(
              top: margin,
              right: margin,
              left: margin,
            ),
            padding: EdgeInsets.all(margin),
            child: Quill.QuillEditor.basic(
              controller: controller,
              readOnly: false, // true for view only mode
            ),
          ),
        ),
      ],
    );
  }

  _contentBody(){
    return DefaultTabController(
      length: 2, 
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            _tabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _tabBody(_answerController),
                  _tabBody(_questionController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      title: "Neue Karteikarte anlegen",
      showAppBar: true,
      body: _contentBody(),
      fab: FloatingActionButton(
        onPressed: _saveFlashcard,
        tooltip: "Karteikarte speichern",
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}