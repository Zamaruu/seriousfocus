import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/learning/add_category_partial.dart';
import 'package:seriousfocus/pages/learning/learning_category_card.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:side_sheet/side_sheet.dart';

class Learningpage extends StatefulWidget {
  Learningpage({Key? key}) : super(key: key);

  @override
  _LearningpageState createState() => _LearningpageState();
}

class _LearningpageState extends State<Learningpage> {
  void createNewCategory(BuildContext context){
    SideSheet.right(
      context: context,
      body: AddCategoryPage(
        refreshCallback: refreshPage,
      ), 
    );
    // showBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.transparent,
    //   builder: (BuildContext context){
    //     return AddCategoryPage(refreshCallback: refreshPage,);
    //   }
    // );
  }

  void refreshPage(){
    setState(() {
      
    });
  }

  List<Widget> _actions(BuildContext context) {
    return <IconButton>[
      IconButton(
        onPressed: refreshPage,
        icon: Icon(Icons.refresh),
        color: Colors.purple,
        splashRadius: Global.splashRadius,
      ),
      IconButton(
        onPressed: () => createNewCategory(context),
        icon: Icon(Icons.add),
        color: Colors.purple,
        splashRadius: Global.splashRadius,
      ),
    ];
  }

  Material _body(BuildContext context){
    return Material(
      color: Colors.white,
      child: FutureBuilder<List<LearningCategoryModel>>(
        future: LearningService().getAllCategories(),
        builder: (BuildContext context, AsyncSnapshot<List<LearningCategoryModel>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else{
            if(snapshot.data!.length >= 1){
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.only(bottom: Global.appPadding * 2),
                  itemBuilder: (context, index){
                    return LearningCategoryCard(model: snapshot.data![index], refreshCallback: refreshPage,);
                  }
                ),
              );
            }
            else{
              return Container(
                padding: EdgeInsets.all(Global.appPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.network("https://assets3.lottiefiles.com/private_files/lf30_bn5winlb.json",),
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: Text("Keine Kategorien vorhanden...\nLege welche mithilfe des '+' an",)
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
      // child: ListView.builder(
      //   itemCount: 5,
      //   padding: EdgeInsets.only(bottom: Global.appPadding * 2),
      //   itemBuilder: (context, index){
      //     return LearningCategoryCard(
      //       categoryData: new LearningCategoryModel(
      //         Colors.blue, 
      //         "Gebiet $index", 
      //       ),
      //     );
      //   }
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Karteikarten",
      actions: _actions(context),
      body: _body(context),
    );
  }
}
