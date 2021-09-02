import 'package:flutter/material.dart';
import 'package:seriousfocus/widgets/global/seriousfocus_appbar.dart';

class SeriousFocusScaffold extends StatelessWidget {
  final Widget? body;
  final bool showAppBar;
  final String title;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final Widget? fab;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  
  const SeriousFocusScaffold({
    Key? key, 
    this.body, 
    this.title = "", 
    this.bottomNavigationBar, 
    this.showAppBar = false, 
    this.actions, 
    this.fab, 
    this.appBar, 
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar != null? appBar: showAppBar? PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SeriousFocusAppBar(title: title, actions: actions,)
      ): null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: fab,
    );
  }
}