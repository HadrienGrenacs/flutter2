import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class BasicDateTimeField<T> extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final String hintText;
  final void Function(DateTime) onChanged;
  final DateTime value;

  BasicDateTimeField({
    this.hintText,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration:
          InputDecoration(labelText: hintText, border: OutlineInputBorder()),
      format: format,
      onShowPicker: (context, value) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: value ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value ?? DateTime.now()),
          );
          onChanged(DateTimeField.combine(date, time));
          return DateTimeField.combine(date, time);
        } else {
          return value;
        }
      },
    );
  }
}
