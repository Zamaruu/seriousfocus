import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/service/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/globals.dart';

class SignUpSection extends StatefulWidget {
  final Function stackCallBack;

  SignUpSection({Key? key, required this.stackCallBack}) : super(key: key);

  @override
  _SignUpSectionState createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<SignUpSection> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _repeatePasswordController = new TextEditingController();
  bool _seeEmailAllowed = false;

  @override
  void initState() { 
    super.initState();
    
  }

  //Methods
  bool checkTextFields(){
    if (_emailController.text.isEmpty) return false;
    else if (_usernameController.text.isEmpty) return false;
    else if (_passwordController.text.isEmpty) return false;
    else if (_repeatePasswordController.text.isEmpty) return false;
    else return true;
  }

  bool passwordsMatch(){
    if(_passwordController.text.trim() == _repeatePasswordController.text.trim()){
      return true;
    }
    else{
      print("passwords do not match");
      return false;
    }
  }

  Future trySignUp(BuildContext context) async {
    if(checkTextFields()){
      if(passwordsMatch()){
        final signUpRes = await context.read<AuthenticationService>().signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _usernameController.text.trim(),
          emailVisible: _seeEmailAllowed,
        );
      }
      else{
        return;
      }
    }
    else{
      return;
    }
  }

  //Widgets
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.125),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "E-Mail",
                          focusColor: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: "Benutzername",
                          focusColor: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Passwort",
                          focusColor: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: TextFormField(
                        controller: _repeatePasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Passwort wiederholen",
                          focusColor: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Global.appMargin),
                      child: CheckboxListTile(
                        value: _seeEmailAllowed,
                        onChanged: (newValue) {
                          setState(() {
                            _seeEmailAllowed = newValue!;
                          });
                        },
                        title: Text("E-Mail für andere sichtbar?"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton.icon(
                      onPressed: () => widget.stackCallBack(0),
                      icon: FaIcon(FontAwesomeIcons.arrowLeft),
                      label: Text("Zurück"),
                      style:
                          TextButton.styleFrom(primary: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton.icon(
                      onPressed: () => trySignUp(context),
                      icon: FaIcon(Icons.person_add),
                      label: Text("Registrieren"),
                      style: TextButton.styleFrom(primary: Colors.purple),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
