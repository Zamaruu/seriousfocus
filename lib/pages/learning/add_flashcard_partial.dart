import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/bloc/learning_flashcard_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_button.dart';

class AddFlashCardPage extends StatefulWidget {
  final Function refreshCallback;
  final String categoryID;

  const AddFlashCardPage({
    Key? key, 
    required this.refreshCallback, 
    required this.categoryID
  }) : super(key: key);

  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashCardPage> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  //Methods
  @override
  void initState() {
    super.initState();
    _questionController = new TextEditingController();
    _answerController = new TextEditingController();
  }

  //Widgets
  Row _header(BuildContext context) {
    return Row(
      children: [
        Text(
          "Neue Karteikarte erstellen",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.clear),
          splashRadius: Global.splashRadius,
          color: Colors.purple,
        ),
      ],
    );
  }

  Row _submit(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SeriousFocusButton(
          margin: EdgeInsets.only(left: Global.appMargin / 2),
          icon: Icons.clear,
          text: "Abbrechen",
          onPressed: () => Navigator.of(context).pop(),
          backgoundColor: Colors.grey,
        ),
        SeriousFocusButton(
          margin: EdgeInsets.only(left: Global.appMargin / 2),
          icon: Icons.create,
          text: "Erstellen",
          onPressed: () async {
            LearningService().createNewFlashcard(
              new LearningFlashcardModel.edit(
                "",
                _questionController.text.trim(), 
                _answerController.text.trim(), 
                widget.categoryID, 
                0,
              ),
            );
            widget.refreshCallback();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Container _body() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(right: Global.appMargin),
              child: TextFormField(
                maxLength: 200,
                maxLines: null,
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: "Frage",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(right: Global.appMargin),
              child: TextFormField(
                maxLength: 200,
                maxLines: null,
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: "Antwort",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(Global.appPadding / 2),
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _body(),
              Spacer(),
              _submit(context),
            ],
          ),
        ),
      ),
    );
  }
}
