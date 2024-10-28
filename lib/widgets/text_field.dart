import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextField buildTextField(
    {bool numeric = false,
    required TextEditingController controller,
    required String hint}) {
  if (numeric == false) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
      ),
    );
  } else {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(filled: true, hintText: hint),
    );
  }
}
