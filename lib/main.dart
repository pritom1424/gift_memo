import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/routes.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/theme_data.dart';
import 'package:gift_memo/features/gift_memo/presentation/pages/home_screen.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "Gift Memo";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    print("home page build called");
    BlocProvider.of<GiftMemoBloc>(context).add(
        GetMemoListEvent(giftMemosFilters: GenericVariables.currentFilter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: HomeScreen(),
    );
  }
}
