import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativoButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const AdaptativoButton({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: Theme.of(context).textTheme.button,
            ),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary));
  }
}
