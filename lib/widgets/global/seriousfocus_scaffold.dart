import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_appbar.dart';

class SeriousFocusScaffold extends StatelessWidget {
  final Widget? body;
  final bool showAppBar;
  final String title;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  
  const SeriousFocusScaffold({
    Key? key, 
    this.body, 
    this.title = "", 
    this.bottomNavigationBar, 
    this.showAppBar = false, 
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar? PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SeriousFocusAppBar(title: title, actions: actions,)
      ): null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}