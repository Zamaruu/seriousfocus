import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/service/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/utils/authentication_response_handler.dart';

class SignInSection extends StatelessWidget {
  final Function stackCallBack;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  SignInSection({ Key? key, required this.stackCallBack }) : super(key: key);

  void _trySignIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      AuthenticationResponseHandler(context: context, errorcode: "no-email");
    }
    else if(password.isEmpty){
      AuthenticationResponseHandler(context: context, errorcode: "no-password");
    }
    else{
      await context.read<AuthenticationService>().signIn(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim(),
        context: context,
      );
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
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.125),
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
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Passwort",
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
                      style: TextButton.styleFrom(
                        primary: Colors.grey.shade700
                      ),
                    ),
                  ),
                  Container(
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton.icon(
                      onPressed: () => _trySignIn(context),
                      icon: FaIcon(FontAwesomeIcons.signInAlt),
                      label: Text("Anmelden"),
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