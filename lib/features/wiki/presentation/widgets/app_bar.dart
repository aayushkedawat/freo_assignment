import 'package:flutter/material.dart';

class CommonAppBar {
  static PreferredSizeWidget buildAppBar(
      {List<Widget>? actions, required String title}) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }
}
