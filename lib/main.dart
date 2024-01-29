import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gift_memo/presentation/screens/giftmemo_listscn.dart';
import 'package:gift_memo/presentation/screens/home_screen.dart';
import 'package:gift_memo/presentation/screens/input_screen.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Memo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => InputScreen()),
                    (route) => false),
                icon: Icon(Icons.add))
          ],
        ),
        body: const HomeScreen());
  }
}
