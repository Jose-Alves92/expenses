import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativoDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativoDatePicker(
      {Key? key, required this.selectedDate, required this.onDateChanged})
      : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicker) {
      if (datePicker == null) {
        return;
      }
      onDateChanged(datePicker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoDatePicker(
            onDateTimeChanged: onDateChanged,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Data seleciona: ${DateFormat('d MMM y').format(selectedDate)}',
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary),
                  onPressed: () => _showDatePicker(context),
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
          );
  }
}
