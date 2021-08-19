import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/bloc/authentication_service.dart';
import 'package:seriousfocus/pages/authentication/loginpage.dart';
import 'package:seriousfocus/pages/mainnavigationpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(SeriousFocusBase());
}

class SeriousFocusBase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return ChangeNotifierProvider(
      create: (context) => AuthenticationService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme
          )
        ),
        home: AuthenticationWrapper(),
        //home: SeriousFocusMainNavigationPage(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child:  CircularProgressIndicator(color: Colors.purple,),
          );
        }
        else if(snapshot.hasData){
          return SeriousFocusMainNavigationPage();
        }
        else if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        else{
          return LoginPage();
        }
      }
    );
    
    //print("Current user: " + firebaseUser.toString());

    // if (firebaseUser != null) {
    //   return SeriousFocusMainNavigationPage();
    // } else {
    //   return LoginPage();
    // }
  }
}