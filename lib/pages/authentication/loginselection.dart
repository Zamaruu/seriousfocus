import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/authentication_service.dart';
import 'package:seriousfocus/widgets/authentication/authbutton.dart';
import 'package:provider/provider.dart';

class LoginSelection extends StatelessWidget {
  final Function stackCallBack;

  const LoginSelection({ Key? key, required this.stackCallBack }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.125),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Hallo!\nWillkommen zurück",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              "Melden Sie sich bei Ihrem Konto an, um fortzufahren",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.normal,),
            ),
          ),
          AuthButton(
            text: "Mit E-Mail anmelden", 
            icon: Icons.email, 
            backgroundColor: 
            Colors.purple, 
            onPressed: () => stackCallBack(1),
          ),
          AuthButton(
            text: "Mit Google anmelden", 
            icon: FontAwesomeIcons.google, 
            backgroundColor: 
            Colors.red, 
            //onPressed: () => context.read<AuthenticationService>().googleSignIn(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            child: Divider(thickness: 2, color: Colors.grey,),
          ),
          Container(
            child: Text(
              "Noch kein Konto? Dann erstelle jetzt eines:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          AuthButton(
            text: "Konto erstellen", 
            icon: Icons.person_add, 
            backgroundColor: Colors.grey,
            onPressed: () => stackCallBack(2),
          ),
        ],
      ),
    );
  }
}

