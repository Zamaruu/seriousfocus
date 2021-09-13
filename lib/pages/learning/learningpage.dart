import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/learning_category_model.dart';
import 'package:seriousfocus/service/caching_service.dart';
import 'package:seriousfocus/service/learning_firebase_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/learning/add_category_partial.dart';
import 'package:seriousfocus/widgets/learning/learning_category_card.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:side_sheet/side_sheet.dart';

class Learningpage extends StatefulWidget {
  Learningpage({Key? key}) : super(key: key);

  @override
  _LearningpageState createState() => _LearningpageState();
}

class _LearningpageState extends State<Learningpage> {
  void createNewCategory(BuildContext context) {
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

  Future<void> refreshPage() async {
    CachingService.cachedLearningCategories = <LearningCategoryModel>[];
    setState(() {
    });
  }

  List<Widget> _actions(BuildContext context) {
    return <IconButton>[
      IconButton(
        onPressed: () => createNewCategory(context),
        icon: Icon(Icons.add),
        color: Colors.purple,
        splashRadius: Global.splashRadius,
      ),
    ];
  }

  Center _bodyContent(List<LearningCategoryModel> categories){
    return Center(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: ListView.builder(
            itemCount: categories.length,
            padding: EdgeInsets.only(bottom: Global.appPadding * 2),
            itemBuilder: (context, index) {
              return LearningCategoryCard(
                model: categories[index],
                refreshCallback: refreshPage,
              );
            }),
      ),
    );
  }

  Container _emptyList(){
    return Container(
      padding: EdgeInsets.all(Global.appPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.network(
            "https://assets3.lottiefiles.com/private_files/lf30_bn5winlb.json",
          ),
          Container(
              margin: EdgeInsets.only(top: Global.appMargin),
              child: Text(
                "Keine Kategorien vorhanden...\nLege welche mithilfe des '+' an",
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    if(CachingService.cachedLearningCategories!.isNotEmpty){
      if(CachingService.cachedLearningCategories!.isNotEmpty){
        return _bodyContent(CachingService.cachedLearningCategories!);
      }
      else{
        return _emptyList();
      }
    } else {
      return Material(
        color: Colors.white,
        child: FutureBuilder<List<LearningCategoryModel>>(
          future: LearningService().getAllCategories(),
          builder: (BuildContext context,
              AsyncSnapshot<List<LearningCategoryModel>> snapshot) {
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
            } else {
              CachingService.cachedLearningCategories = snapshot.data!;
              if (snapshot.data!.length >= 1) {
                return _bodyContent(snapshot.data!);
              } else {
                return _emptyList();
              }
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Karteikarten",
      actions: _actions(context),
      body: _bodyBuilder(context),
    );
  }
}
