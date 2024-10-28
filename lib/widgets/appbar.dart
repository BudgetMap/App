import 'package:flutter/material.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    title: Text(
      title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontFamily: Theme.of(context).textTheme.displaySmall?.fontFamily,
          fontSize: Theme.of(context).textTheme.displaySmall?.fontSize),
    ),
    toolbarHeight: 60,
  );
}
