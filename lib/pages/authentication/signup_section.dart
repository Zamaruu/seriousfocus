import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpSection extends StatelessWidget {
  final Function stackCallBack;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _repeatePasswordController = new TextEditingController();

  SignUpSection({Key? key, required this.stackCallBack}) : super(key: key);

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
        );
        // if(signUpRes == "200"){
        //   final signInRes = await context.read<AuthenticationService>().signIn(
        //     email: _emailController.text.trim(),
        //     password: _passwordController.text.trim(),
        //   );
        //   print("Loginresult: $signInRes");
        // }
        // else{
        //   return;
        // }
      }
      else{
        return;
      }
    }
    else{
      return;
    }
  }

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
                      margin: EdgeInsets.only(top: 15),
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
                      margin: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: "Benutzername",
                          focusColor: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
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
                      margin: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: _repeatePasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Passwort wiederholen",
                          focusColor: Colors.purple,
                        ),
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
                      onPressed: () => stackCallBack(0),
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
