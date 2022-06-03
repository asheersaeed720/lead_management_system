import 'package:flutter/material.dart';
import 'package:lead_management_system/utils/constants.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String labelTxt,
  Widget? preffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
    labelText: labelTxt,
    prefixIcon: preffixIcon,
  );
}

InputDecoration buildPasswordInputDecoration(
  context, {
  required String labelTxt,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
    labelText: labelTxt,
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: suffixIcon,
  );
}
