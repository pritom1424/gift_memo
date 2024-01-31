import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:gift_memo/presentation/widgets/giftmemo_listscn.dart';
import 'package:gift_memo/presentation/widgets/topFilters_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<GiftMemoManager>(context, listen: false)
            .fetchMemoList(),
        builder: (ctx, snapShot) =>
            (snapShot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Column(
                    children: [
                      Flexible(child: TopBarFiltersWidget()),
                      Flexible(flex: 3, child: GiftMemoListScreen()),
                    ],
                  ));
  }
}
