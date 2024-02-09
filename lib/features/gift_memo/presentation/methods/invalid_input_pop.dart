import 'package:flutter/material.dart';

class InvalidInputPop {
  Future<dynamic> invalidInputPop(BuildContext ctx, String message) {
    return showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
              title: const Text("Invalid Input"),
              content: Text(
                message,
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Ok"))
              ],
            ));
  }
}
