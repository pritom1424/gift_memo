import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:gift_memo/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 139, 222),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GiftMemoManager())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Memo',
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Amity_Jack',
                color: kColorScheme.onSecondaryContainer,
                fontSize: 18,
              ),
              labelLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 20,
              ),
              bodyLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
              bodyMedium: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'QuickSand-Medium',
                color: kColorScheme.onSecondaryContainer,
                fontSize: 15,
              ),
              bodySmall: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Advent-Lt1',
                color: kColorScheme.onSecondaryContainer,
                fontSize: 12,
              ),
            ),
      ),
      // home: const MyHomePage(),
      routes: CustomWidgetsUtils().routeList(context),
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  Values.currentMemoModel = null;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Values.inputScreenRouteName, (route) => false);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: const HomeScreen());
  }
}
