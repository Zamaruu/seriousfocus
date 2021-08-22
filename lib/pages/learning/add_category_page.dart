import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_button.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({ Key? key }) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  late Color _categoryColor;
  late TextEditingController _nameController;

  //Methods
  @override
  void initState() { 
    super.initState();
    _categoryColor = Colors.blue;
    _nameController = new TextEditingController();
  }

  void _colorPicker(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _categoryColor,
              onColorChanged: (color){
                setState(() {
                  _categoryColor = color;
                });
                Navigator.of(context).pop();
              },
              enableLabel: true,
            ),
          ),
        );
      },
    );
  }

  //Widgets
  Row _header(BuildContext context){
    return Row(
      children: [
        Text(
          "Neue Kategorie erstellen",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: Icon(Icons.clear),
          splashRadius: Global().splashRadius,
          color: Colors.purple,
        ),
      ],
    );
  }

  Row _submit(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SeriousFocusButton(
          margin: EdgeInsets.only(left: Global().appMargin / 2),
          icon: Icons.clear, 
          text: "Abbrechen", 
          onPressed: () => Navigator.of(context).pop(), 
          backgoundColor: Colors.grey,
        ),
        SeriousFocusButton(
          margin: EdgeInsets.only(left: Global().appMargin / 2),
          icon: Icons.create, 
          text: "Erstellen", 
          onPressed: (){},
        )
      ],
    );
  }

  Container _body(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            maxLength: 30,
            decoration: InputDecoration(
              labelText: "Kategoriename",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: _categoryColor,
              ),
              SeriousFocusButton(
                margin: EdgeInsets.only(left: Global().appMargin / 2),
                icon: Icons.color_lens,
                backgoundColor: _categoryColor,
                text: "Farbe auswählen",
                onPressed: _colorPicker,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Global().appPadding, right: Global().appPadding, bottom: Global().appPadding * 2),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 6.0,
        child: Container(
          padding: EdgeInsets.all(Global().appPadding),
          width: MediaQuery.of(context).size.width,
          height: 300,
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
      ),
    );
  }
}