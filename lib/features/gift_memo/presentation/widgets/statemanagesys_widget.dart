import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';

class StateManagementSystemWidget extends StatelessWidget {
  final Widget widget;
  const StateManagementSystemWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftMemoBloc, GiftMemoState>(builder: (ctx, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetLoadedState) {
        return widget;
      } else if (state is ErrorState) {
        return Center(
          child: Text(state.message),
        );
      }

      return const Center(child: Text("Loading..."));
    });
  }
}
