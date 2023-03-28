import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget desktopScaffold;
  Responsive({
    required this.mobileScaffold,
    required this.desktopScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}
