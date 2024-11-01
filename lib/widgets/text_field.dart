import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField buildTextField(
    {required BuildContext context,
    bool numeric = false,
    required TextEditingController controller,
    required String hint}) {
  if (numeric == false) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize)),
    );
  } else {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize)),
    );
  }
}
