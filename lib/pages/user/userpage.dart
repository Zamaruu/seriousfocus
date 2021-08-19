import 'package:flutter/material.dart';
import 'package:seriousfocus/bloc/authentication_service.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';
import 'package:provider/provider.dart';

class Userpage extends StatelessWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Benutzer",
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<AuthenticationService>().logout(), 
          child: Text("Abmelden"),
        ),
      ),
    );
  }
}
