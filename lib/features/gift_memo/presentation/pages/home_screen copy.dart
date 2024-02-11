import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/core/converters/converters.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/giftmemo_listscn.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/topFilters_widget.dart';

class HomeScreenCopy extends StatelessWidget {
  final GiftMemoState state;
  const HomeScreenCopy({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    print("home screen build called");

    if (state is LoadingState) {
      print("loading emitted!");
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is GetLoadedState) {
      final GetLoadedState modState = state as GetLoadedState;
      final filteredList = GiftsFilterTypeToGiftListConverter(
              giftMemos: modState.memos, mType: GenericVariables.currentFilter)
          .getfilterdMemo;
      print("get loaded emitted!");
      return Column(
        children: [
          Flexible(child: TopBarFiltersWidget(memos: modState.memos)),
          Flexible(flex: 2, child: GiftMemoListScreen(memos: filteredList)),
        ],
      );
    } else if (state is ErrorState) {
      print("error emitted!");
      final ErrorState modState = state as ErrorState;
      return Center(
        child: Text(modState.message),
      );
    }

    return const Center(child: Text("Loading..."));

    /* return BlocConsumer<GiftMemoBloc, GiftMemoState>(
        listener: (context, state) {
      if (state is VoidLoadedState) {
        BlocProvider.of<GiftMemoBloc>(context).add(
            GetMemoListEvent(giftMemosFilters: GenericVariables.currentFilter));
      }
    }, builder: (ctx, state) {
      print("home state: ${state.toString()}");
      if (state is LoadingState) {
        print("loading emitted!");
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetLoadedState) {
        final filteredList = GiftsFilterTypeToGiftListConverter(
                giftMemos: state.memos, mType: GenericVariables.currentFilter)
            .getfilterdMemo;
        print("get loaded emitted!");
        return Column(
          children: [
            Flexible(child: TopBarFiltersWidget(memos: state.memos)),
            Flexible(flex: 2, child: GiftMemoListScreen(memos: filteredList)),
          ],
        );
      } else if (state is ErrorState) {
        print("error emitted!");
        return Center(
          child: Text(state.message),
        );
      }

      return const Center(child: Text("Loading..."));
    }); */
  }
}
