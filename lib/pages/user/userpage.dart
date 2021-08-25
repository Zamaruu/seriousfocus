import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seriousfocus/bloc/authentication_service.dart';
import 'package:seriousfocus/bloc/firebase_user_service.dart';
import 'package:seriousfocus/globals.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_textbutton.dart';
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

  Future<dynamic> _deleteAccountDialog(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Konto löschen'),
          content: Container(
            child: Text(
              "Möchten Sie wirkliche Ihr Konto unwiderruflich löschen?"
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

  //Widgtes

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Benutzer",
      body: Material(
        color: Colors.white,
        child: Container(
          //color: Colors.white,
          padding: EdgeInsets.only(left: Global.appPadding, top: Global.appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user!.photoURL != null?
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.purple,
                  backgroundImage: NetworkImage(user.photoURL!),
                ):
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.purple,
                  child: FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 40,),
                ),
              if(user.photoURL == null)
                UserDataTile(
                  margin: EdgeInsets.only(top: Global.appMargin),
                  icon: Icons.cloud_upload,
                  title: "Bild hochladen",
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      String url = await UserService().uploadFile(file);
                      await user.reload();

                      setState(() {
                      });
                    }
                  },
                ),
              if(user.displayName != null)
                if(user.displayName!.isNotEmpty)
                  UserDataTile(
                    //margin: EdgeInsets.only(top: Global.appMargin),
                    icon: FontAwesomeIcons.signature, 
                    title: user.displayName!, 
                    onTap: (){},
                  ),
              UserDataTile(
                margin: user.photoURL != null? EdgeInsets.only(top: Global.appMargin): EdgeInsets.zero,
                icon: FontAwesomeIcons.envelope,
                title: user.email!,
                onTap: () {
                  _launchURL("mailto:"+user.email!);
                },
              ),
              if (user.photoURL != null)
                UserDataTile(
                  icon: Icons.cloud_upload,
                  title: "Bild aktualisieren",
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path!);
                      String url = await UserService().uploadFile(file);
                      await user.reload();
                      setState(() {
                      });
                    }
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
