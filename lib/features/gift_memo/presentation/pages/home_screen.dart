import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/core/converters/converters.dart';
import 'package:gift_memo/core/generics/constants.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/giftmemo_listscn.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/topFilters_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.APPNAME),
          actions: [
            IconButton(
                onPressed: () {
                  GenericVariables.currentGiftMemo = null;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      GenericVariables.inputScreenRouteName, (route) => false);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<GiftMemoBloc, GiftMemoState>(builder: (ctx, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetLoadedState) {
            final filteredList = GiftsFilterTypeToGiftListConverter(
                    giftMemos: state.memos,
                    mType: GenericVariables.currentFilter)
                .getfilterdMemo;

            return Column(
              children: [
                Flexible(child: TopBarFiltersWidget(memos: state.memos)),
                Flexible(
                    flex: 2, child: GiftMemoListScreen(memos: filteredList)),
              ],
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          context.read<GiftMemoBloc>().add(GetMemoListEvent(
              giftMemosFilters: GenericVariables.currentFilter));
          return Center(child: Text("Loading..."));
        }));
  }
}
