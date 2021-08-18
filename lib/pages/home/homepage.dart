import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class Homepage extends StatelessWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Startseite",
    );
  }
}