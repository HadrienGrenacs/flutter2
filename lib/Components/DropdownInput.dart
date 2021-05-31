import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
      decoration:
          InputDecoration(labelText: hintText, border: OutlineInputBorder()),
      value: value,
      onChanged: onChanged,
      items: options.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(getLabel(value)),
        );
      }).toList(),
    );
  }
}
