import 'package:flutter/material.dart';

class CustomWidgetsUtils {
  Widget topfilterButton(String name, Function onPress) =>
      ElevatedButton(onPressed: () => onPress(), child: Text(name));

  Future<bool?> deleteAlertDialoguePop(BuildContext context) => showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: const Text("Are you sure?"),
            content: Text(
              "Do you want to delete this transaction?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("No"))
            ],
          ));
}
