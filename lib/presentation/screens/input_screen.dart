import 'package:flutter/material.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
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
  late TextEditingController moneyAmountInputController;
  late TextEditingController giftAmountInputController;
  @override
  void initState() {
    guestNameInputController = TextEditingController();
    giftInputController = TextEditingController();
    moneyInputController = TextEditingController();
    moneyAmountInputController = TextEditingController();
    giftAmountInputController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    guestNameInputController.dispose();
    moneyInputController.dispose();
    giftInputController.dispose();
    moneyAmountInputController.dispose();
    giftAmountInputController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  guestNameInputController.text = "selina";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: guestNameInputController,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Gift "),
                            keyboardType: TextInputType.number,
                            controller: giftInputController,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Amount "),
                            keyboardType: TextInputType.number,
                            controller: giftInputController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Money"),
                            keyboardType: TextInputType.number,
                            controller: moneyInputController,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: "Amount"),
                            keyboardType: TextInputType.number,
                            controller: moneyInputController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FittedBox(
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Save")),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil("/", (route) => false),
                      child: const Text("Cancel"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
