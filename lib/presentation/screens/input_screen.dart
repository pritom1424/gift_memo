import 'package:flutter/material.dart';
import 'package:gift_memo/main.dart';
import 'package:gift_memo/presentation/screens/home_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late TextEditingController guestNameInputController;
  late TextEditingController giftInputController;
  late TextEditingController moneyInputController;
  @override
  void initState() {
    guestNameInputController = TextEditingController();
    giftInputController = TextEditingController();
    moneyInputController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    guestNameInputController.dispose();
    moneyInputController.dispose();
    giftInputController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: guestNameInputController,
              ),
            ),
            Container(
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: giftInputController,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: moneyInputController,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (ctx) => MyHomePage()),
                            (route) => false);
                      },
                      child: Text("Cancel"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
