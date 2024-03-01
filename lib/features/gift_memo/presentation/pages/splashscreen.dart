import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_memo/core/generics/app_path.dart';
import 'package:gift_memo/core/generics/variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, GenericVariables.homeScreenRouteName);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: scSize.height * 0.05,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Image.asset(
              width: scSize.height * 0.05,
              height: scSize.height * 0.05,
              AppPath.iconPath,
            ),
          ),
          Text(
            "Please wait....",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ]),
      ),
    );
  }
}
