import 'package:flutter/material.dart';

Widget customDropdownField<TItem>(String label, List<TItem> items,
    String Function(TItem?) chooseItemLabel, void Function(TItem?) onChanged) {
  return DropdownButtonFormField<TItem>(
    isExpanded: true,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    items: items.map((TItem value) {
      return DropdownMenuItem<TItem>(
        value: value,
        child: Text(chooseItemLabel(value)),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
