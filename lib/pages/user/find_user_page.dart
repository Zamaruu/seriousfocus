import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/seriousfocus_user_model.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/pages/user/userpage.dart';
import 'package:seriousfocus/service/firebase_user_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_useravatar.dart';

class FindUserPage extends StatefulWidget {
  FindUserPage({Key? key}) : super(key: key);

  @override
  _FindUserPageState createState() => _FindUserPageState();
}

class _FindUserPageState extends State<FindUserPage> {
  late TextEditingController _queryController;
  late bool _showQueryField;
  late String _queryString;

  @override
  void initState() { 
    super.initState();
    _queryString = "";
    _showQueryField = false;
    _queryController = new TextEditingController();
  }

  void _queryFirestore(String query){
    setState(() {
      _queryString = query.trim();
    });
  }

  Container _searchField(){
    return Container(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Global.appPadding,
              top: Global.appPadding,
              bottom: Global.appPadding,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _queryController,
              onSubmitted: (query) => _queryFirestore(query),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: () => _queryFirestore(_queryController.text),
            splashRadius: Global.splashRadius,
            icon: Icon(Icons.search),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: () {
              setState(() {
                _showQueryField = false;
                _queryController.text = "";
                _queryString = "";
              });
            },
            splashRadius: Global.splashRadius, 
            icon: Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

  Column _body(List<UserModel> users){
    return Column(
      children: [
        if(_showQueryField)
          _searchField(),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              UserModel user = users[index];
              return ListTile(
                key: Key(user.uid),
                leading: SeriousFocusUserAvatar(
                  radius: 40,
                  userDisplayName: user.displayName,
                  backgroundColor: Color(user.userColor),
                ),
                title: Text(user.displayName),
                subtitle: user.emailVisible?
                  Text(user.getEmail()):
                  null,
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Userpage(user: user,)
                    )
                  );
                },
              );
            }
          ),
        ),
      ],
    );
  }

  FutureBuilder _pageBuilder(){
    return FutureBuilder<List<UserModel>>(
      future: UserService().getAllUsers(query: _queryString),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else{
          return _body(snapshot.data!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: _pageBuilder(),
      ),
      fab: Container(
        margin: EdgeInsets.only(bottom: Global.appMargin * 3.5),
        child: FloatingActionButton(
          onPressed: (){
            setState(() {
              _showQueryField = !_showQueryField;
            });
          },
          child: Icon(_showQueryField? Icons.clear: Icons.search, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor,
          
        ),
      ),
    );
  }
}