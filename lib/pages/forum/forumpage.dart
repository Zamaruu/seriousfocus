import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_scaffold.dart';

class Forumpage extends StatelessWidget {
  const Forumpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeriousFocusScaffold(
      showAppBar: true,
      title: "Forum",
    );
  }
}
