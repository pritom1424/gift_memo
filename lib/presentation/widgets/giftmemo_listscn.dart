import 'package:flutter/material.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:provider/provider.dart';

class GiftMemoListScreen extends StatelessWidget {
  const GiftMemoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<GiftMemoManager>(context, listen: false).fetchMemoList(),
      builder: (ctx, snapShot) =>
          (snapShot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GiftMemoManager>(
                  child: const Center(
                    child: Center(
                        child: Text(
                      'No entry yet. Add some entries to start! ',
                    )),
                  ),
                  builder: (ctx, gManager, ch) {
                    final memoList =
                        gManager.getfilterdMemo(Values.currentMemolistType);

                    print(Values.currentMemolistType);

                    return memoList.isEmpty
                        ? ch!
                        : CustomWidgetsUtils()
                            .showMemoList(memoList, gManager, context);
                  }),
    );
  }
}
