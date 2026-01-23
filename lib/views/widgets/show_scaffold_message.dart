import 'package:flutter/material.dart';

ScaffoldFeatureController showScaffoldMessage(String message, BuildContext context) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));
}
