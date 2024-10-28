import 'package:flutter/material.dart';

OutlinedButton buildSmallOutlinedButton(
    {required BuildContext context,
    required String text,
    required void Function()? onPress,
    Color? color,
    Color? onColor}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: onColor ?? Theme.of(context).colorScheme.surface,
        side: BorderSide(
            width: 1.0, color: Theme.of(context).colorScheme.outlineVariant)),
    onPressed: onPress,
    child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: color ?? Theme.of(context).colorScheme.primary,
              fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
        )),
  );
}
