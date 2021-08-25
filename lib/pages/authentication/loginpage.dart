import 'package:flutter/material.dart';
import 'package:seriousfocus/pages/authentication/loginselection.dart';
import 'package:seriousfocus/pages/authentication/signin_section.dart';
import 'package:seriousfocus/pages/authentication/signup_section.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class LoginPage extends StatefulWidget {

  LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late int _stackIndex;

  @override
  void initState() { 
    super.initState();
    _stackIndex = 0;
  }

  void setStackIndex(int newIndex){
    setState(() {
      _stackIndex = newIndex;
    });
  }

  Stack _body(){
    return IndexedStack(
      index: _stackIndex,
      children: [
        LoginSelection(stackCallBack: setStackIndex,),
        SignInSection(stackCallBack: setStackIndex,),
        SignUpSection(stackCallBack: setStackIndex,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: false,
      body: Container(
        child: _body(),
      ),
    );
  }
}