import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Startseite",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.displayName ?? "Kein DisplayName"),
            Text(user.email!),
            Text(user.uid)
          ],
        ),
      ),
    );
  }
}