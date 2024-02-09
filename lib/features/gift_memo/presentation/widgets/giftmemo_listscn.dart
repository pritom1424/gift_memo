import 'package:flutter/material.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/single_gift_memo_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftMemoListScreen extends StatelessWidget {
  final List<GiftMemo> memos;
  const GiftMemoListScreen({super.key, required this.memos});

  @override
  Widget build(BuildContext context) {
    return (memos.isEmpty)
        ? const Center(
            child: Text(
            'No entry yet. Add some entries to start! ',
          ))
        : ListView.builder(
            itemCount: memos.length,
            itemBuilder: (ctx, i) => Dismissible(
                  onDismissed: (dis) {},
                  key: ValueKey(memos),
                  confirmDismiss: (dir) => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text("Are you sure?"),
                            content: Text(
                              "Do you want to delete this record?",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<GiftMemoBloc>(context).add(
                                        DeleteMemoFromListEvent(
                                            giftMemo: memos[i]));
                                    return Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("No"))
                            ],
                          )),
                  child: SingleGiftMemoCard(memos[i]),
                ));
  }
}
