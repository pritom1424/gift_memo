import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/totalsummary_widget.dart';

class TopBarFiltersWidget extends StatelessWidget {
  final List<GiftMemo> memos;
  const TopBarFiltersWidget({super.key, required this.memos});
  Row topBarFilters(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            GenericVariables.currentFilter = GiftMemosFilters.all;
            BlocProvider.of<GiftMemoBloc>(ctx).add(GetMemoListEvent(
                giftMemosFilters: GenericVariables.currentFilter));
          },
          child: const Text('All'),
        ),
        ElevatedButton(
          onPressed: () {
            GenericVariables.currentFilter = GiftMemosFilters.gift;
            BlocProvider.of<GiftMemoBloc>(ctx).add(GetMemoListEvent(
                giftMemosFilters: GenericVariables.currentFilter));
          },
          child: const Text('Gift'),
        ),
        ElevatedButton(
          onPressed: () {
            GenericVariables.currentFilter = GiftMemosFilters.money;
            BlocProvider.of<GiftMemoBloc>(ctx).add(GetMemoListEvent(
                giftMemosFilters: GenericVariables.currentFilter));
          },
          child: const Text('Money'),
        ),
        ElevatedButton(
          onPressed: () {
            GenericVariables.currentFilter = GiftMemosFilters.both;
            BlocProvider.of<GiftMemoBloc>(ctx).add(GetMemoListEvent(
                giftMemosFilters: GenericVariables.currentFilter));
          },
          child: const Text('Both'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scSize = MediaQuery.of(context).size;
    return (memos.isEmpty)
        ? topBarFilters(context)
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TotalSummaryWidget(scSize.height * 0.025, memos),
                const Text("Summary"),
                topBarFilters(context)
              ],
            ),
          );
  }
}
