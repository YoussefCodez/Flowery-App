import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    titleSpacing: -10,

    title: const Text("My orders"),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
  );
}