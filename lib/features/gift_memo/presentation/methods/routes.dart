import 'package:flutter/material.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/presentation/pages/home_screen.dart';
import 'package:gift_memo/features/gift_memo/presentation/pages/input_screen.dart';
import 'package:gift_memo/main.dart';

class GiftMemoRoutes {
  static Map<String, Widget Function(BuildContext)> routes() {
    return {
      "/": (ctx) => const MyHomePage(),
      GenericVariables.homeScreenRouteName: (ctx) => const HomeScreen(),
      GenericVariables.inputScreenRouteName: (ctx) => const InputScreen(),
    };
  }
}
