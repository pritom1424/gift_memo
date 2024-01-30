import 'package:flutter/material.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:gift_memo/main.dart';

import 'package:gift_memo/presentation/screens/home_screen.dart';
import 'package:gift_memo/presentation/screens/input_screen.dart';
import 'package:gift_memo/presentation/widgets/single_gift_memo_card.dart';

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

  Map<String, Widget Function(BuildContext)> routeList(BuildContext ctx) => {
        "/": (ctx) => const MyHomePage(),
        Values.homeScreenRouteName: (ctx) => const HomeScreen(),
        Values.inputScreenRouteName: (ctx) => const InputScreen(),
      };
  ListView showMemoList(List<GiftMemoModel> memoList, GiftMemoManager gManager,
      BuildContext context) {
    return ListView.builder(
      itemCount: memoList.length,
      itemBuilder: (ctx, i) => Dismissible(
        onDismissed: (dis) {
          final removeItem = memoList[i];
          gManager.removeMemo(removeItem);
        },
        key: ValueKey(memoList),
        confirmDismiss: (dir) =>
            CustomWidgetsUtils().deleteAlertDialoguePop(context),
        child: SingleGiftMemoCard(memoList[i]),
      ),
    );
  }

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
