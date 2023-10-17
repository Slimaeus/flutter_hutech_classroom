import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context,
    {required String title,
    bool hasLeading = false,
    List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    automaticallyImplyLeading: hasLeading,
    actions: actions,
  );
}
