import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativoTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String label;
  final Function(String) onSubmitted;

  const AdaptativoTextField(
      {Key? key,
      required this.keyboardType,
      required this.controller,
      required this.label,
      required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            keyboardType: keyboardType,
            controller: controller,
            placeholder: label,
            onSubmitted: onSubmitted,
          )
        : TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(labelText: label),
            onSubmitted: onSubmitted,
          );
  }
}
