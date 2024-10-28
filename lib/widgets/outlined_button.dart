import 'package:flutter/material.dart';

OutlinedButton buildOutlinedButton(
    {required BuildContext context,
    required String text,
    required void Function()? onPress}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.only(top: 10),
        side: BorderSide(
            width: 1.0, color: Theme.of(context).colorScheme.outlineVariant)),
    onPressed: onPress,
    child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily:
                  Theme.of(context).textTheme.headlineMedium?.fontFamily,
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize),
        )),
  );
}
