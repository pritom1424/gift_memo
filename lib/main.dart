import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/routes.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/theme_data.dart';
import 'package:gift_memo/features/gift_memo/presentation/pages/splashscreen.dart';
import 'package:uuid/uuid.dart';
import 'injection_container.dart' as di;

const uuid = Uuid();
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 139, 222),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<GiftMemoBloc>(),
      child: MaterialApp(
        title: 'Gift Memo',
        theme: GiftMemoThemeData.getThemeData(kColorScheme),
        // home: const MyHomePage(),
        routes: GiftMemoRoutes.routes(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
