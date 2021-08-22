import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_textbutton.dart';

class LearningCategoryCard extends StatelessWidget {
  final double height;
  final Function? onPressed;
  final LearningCategoryModel categoryData;

  LearningCategoryCard({
    Key? key, 
    this.height = 154.0, 
    this.onPressed, 
    required this.categoryData 
  }) : super(key: key);

  //Widgets
  Row _header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: categoryData.categoryColor,
          child: Text(
            categoryData.name.trim()[0].toUpperCase(),
            style: TextStyle(
              color: categoryData.categoryColor.computeLuminance() > 0.5 ? Colors.black: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: Global.appMargin),
          child: Text(
            categoryData.name,
            style: TextStyle(
              color: categoryData.categoryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
          ),
        ),
      ],
    );
  }

  Row _actions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){},
          icon: FaIcon(Icons.delete),
          splashRadius: Global.splashRadius,
          color: Colors.purple,
        ),
        IconButton(
          onPressed: () {},
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
          onTap: (){},
          splashColor: categoryData.categoryColor.withOpacity(0.3),
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
                      text: '${categoryData.childrenCount} ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: 'Elemente in diesem Gebiet!', style: DefaultTextStyle.of(context).style),
                      ],
                    ),
                  ),
                  //child: Text("${categoryData.childrenCount} Elemente in diesem Gebiet!"),
                ),
                Spacer(),
                _actions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}