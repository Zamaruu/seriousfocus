import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/seriousfocus_user_model.dart';
import 'package:seriousfocus/service/authentication_service.dart';
import 'package:seriousfocus/service/firebase_user_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_textbutton.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_useravatar.dart';
import 'package:seriousfocus/widgets/user/userdatatile.dart';
import 'package:url_launcher/url_launcher.dart';

class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {

  //Methods
  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void refreshPage(){
    setState(() {
      
    });
  }

  Future<dynamic> _deleteAccountDialog(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Konto löschen'),
          content: Container(
            child: Text(
              "Möchten Sie wirklich Ihr Konto unwiderruflich löschen?"
            ),
          ),
          actions: <Widget>[
            SeriousFocusTextButton(
              icon: Icons.arrow_back, 
              text: "Abbrechen",
              onPressed: () => Navigator.of(context).pop(),
            ),
            SeriousFocusTextButton(
              icon: Icons.delete,
              backgoundColor: Colors.red,
              contentColor:  Colors.red, 
              text: "Konto löschen",
              onPressed: () => context.read<AuthenticationService>().deleteAccount(),
            ),
          ],
        );
      }
    );
  }

  Future changeEmailVisibleStatus(BuildContext context, UserModel user, bool newValue) async {
    Global.seriousFocusAlert(
      context, 
      success: true,
      onPressed: ()async{
        await user.changeEmailVisibleStatus(newValue);
        Navigator.pop(context);
        refreshPage();
      }, 
      title: "Sichtbarkeit ändern", 
      content: "Wollen Sie wirklich die Sichtbarkeit Ihrer E-Mail Adresse ändern?", 
      onPressedText: "Ja, Ändern"
    );
  }

  void changeUserColor(BuildContext context, UserModel user){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Benutzerfarbe ändern"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: Color(user.userColor),
              onColorChanged: (color) async {
                await user.changeUserColor(color);
                Navigator.of(context).pop();
                refreshPage();
              },
            ),
          ),
        );
      },
    );
  }

  //Widgtes
  Material _body(UserModel user){
    return Material(
      color: Colors.white,
      child: Container(
        height: double.maxFinite,
        child: SingleChildScrollView(
          //color: Colors.white,
          padding: EdgeInsets.only(left: Global.appPadding, top: Global.appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeriousFocusUserAvatar(
                userDisplayName: user.displayName, 
                backgroundColor: Color(user.userColor),
                radius: 60,
              ),
              // CircleAvatar(
              //   radius: 60,
              //   backgroundColor: Colors.purple,
              //   child: FaIcon(
              //     FontAwesomeIcons.user,
              //     color: Colors.white,
              //     size: 40,
              //   ),
              // ),
              if (user.displayName.isNotEmpty)
                UserDataTile(
                  margin: EdgeInsets.only(top: Global.appMargin),
                  icon: FontAwesomeIcons.signature,
                  title: user.displayName,
                  onTap: () {},
                ),
              if(user.getEmail().isNotEmpty)
                UserDataTile(
                  icon: FontAwesomeIcons.envelope,
                  title: user.getEmail(),
                  onTap: () {
                    _launchURL("mailto:"+user.getEmail());
                  },
                ),
              UserDataTile(
                icon: user.emailVisible? FontAwesomeIcons.check: FontAwesomeIcons.timesCircle, 
                title: user.emailVisible? "E-Mail Addresse sichtbar": "E-Mail Adresse nicht sichtbar", 
                onTap: () => changeEmailVisibleStatus(context, user, !user.emailVisible),
              ),
              UserDataTile.color(
                onTap: () => changeUserColor(context, user), 
                userColor: Color(user.userColor),
              ),
              UserDataTile(
                icon: Icons.delete,
                title: "Konto löschen",
                onTap: () => _deleteAccountDialog(context),
              ),
              UserDataTile(
                icon: FontAwesomeIcons.signOutAlt,
                title: "Abmelden",
                onTap: () => context.read<AuthenticationService>().logout(), 
              ),
              SizedBox(height: Global.listviewBottomSpace,)
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder _userPageBuilder(){
    return FutureBuilder<UserModel>(
      future: UserService().getCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
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
      showAppBar: true,
      title: "Benutzer",
      body: _userPageBuilder(),
    );
  }
}
