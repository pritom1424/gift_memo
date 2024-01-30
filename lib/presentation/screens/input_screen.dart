import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/utils.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:gift_memo/main.dart';
import 'package:provider/provider.dart';

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
  DateTime _pickedDate = DateTime.now();
  GuestGender _selectedGender = GuestGender.male;
  void saveMemo() {
    if (double.tryParse(moneyAmountInputController.text) == null ||
        int.tryParse(giftAmountInputController.text) == null) {
      CustomWidgetsUtils().invalidInputPop(context, Values.inavlidInputMessage);
      return;
    }
    if (guestNameInputController.text == "" ||
        giftInputController.text == "" ||
        moneyInputController.text == "" ||
        moneyAmountInputController.text == "" ||
        giftAmountInputController.text == "") {
      CustomWidgetsUtils().invalidInputPop(context, Values.blankInputMessage);
      return;
    }
    final double moneyAmount =
        double.tryParse(moneyAmountInputController.text)!;
    final int giftAmount = int.tryParse(giftAmountInputController.text)!;

    if (guestNameInputController.text == "" ||
        giftInputController.text == "" ||
        moneyInputController.text == "" ||
        giftAmount < 0 ||
        moneyAmount < 0) {
      CustomWidgetsUtils().invalidInputPop(context, Values.invalidValue);
      return;
    }

    print("$giftAmount + money: $moneyAmount");
    if (giftAmount == 0 && moneyAmount == 0) {
      CustomWidgetsUtils().invalidInputPop(
          context, "Pls give any amount >0 in gift amount or money amount");
      return;
    }

    GiftMemoModel newMemo = GiftMemoModel(
        id: uuid.v4(),
        name: guestNameInputController.text,
        gift: Gift(
          giftName: giftInputController.text,
          giftMoneyName: moneyInputController.text,
          giftAmount: giftAmount,
          moneyAmount: moneyAmount,
          gType: Utils().inputAmountsToGiftType(giftAmount, moneyAmount),
        ),
        gender: _selectedGender,
        date: _pickedDate);
    print(Utils().inputAmountsToGiftType(giftAmount, moneyAmount));
    (Values.currentMemoModel != null)
        ? Provider.of<GiftMemoManager>(context, listen: false)
            .updateMemo(Values.currentMemoModel!.id, newMemo)
        : Provider.of<GiftMemoManager>(context, listen: false).addMemo(newMemo);
    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
  }

  void showCalender(BuildContext ct) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
        context: ct, initialDate: now, firstDate: firstDate, lastDate: now);

    if (selectedDate != null) {
      setState(() {
        _pickedDate = selectedDate;
      });
    }
  }

  @override
  void initState() {
    guestNameInputController = TextEditingController();

    giftInputController = TextEditingController();

    moneyInputController = TextEditingController();

    moneyAmountInputController = TextEditingController();
    giftAmountInputController = TextEditingController();

    if (Values.currentMemoModel != null) {
      guestNameInputController.text = Values.currentMemoModel!.name;
      moneyInputController.text = Values.currentMemoModel!.gift.giftMoneyName;
      giftInputController.text = Values.currentMemoModel!.gift.giftName;
      giftAmountInputController.text =
          Values.currentMemoModel!.gift.giftAmount.toString();
      moneyAmountInputController.text =
          Values.currentMemoModel!.gift.moneyAmount.toString();

      _selectedGender = Values.currentMemoModel!.gender;
      _pickedDate = Values.currentMemoModel!.date;
    }

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
              child: Flexible(
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextField(
                        decoration: const InputDecoration(labelText: "Name"),
                        controller: guestNameInputController,
                      ),
                    ),
                    Flexible(
                      child: DropdownButton(
                          value: _selectedGender,
                          items: GuestGender.values
                              .map((ge) => DropdownMenuItem(
                                  value: ge,
                                  child: Text(ge.name.toUpperCase())))
                              .toList(),
                          onChanged: (val) {
                            if (val == null) {
                              return;
                            }
                            setState(() {
                              _selectedGender = val;
                            });
                          }),
                    )
                  ],
                ),
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
                                const InputDecoration(hintText: "Gift "),
                            controller: giftInputController,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                const InputDecoration(hintText: "Amount"),
                            keyboardType: TextInputType.number,
                            controller: giftAmountInputController,
                            onChanged: (amt) {
                              int amount = int.tryParse(amt) ?? 0;
                              giftAmountInputController.text =
                                  amount.toString();
                            },
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
                            decoration: const InputDecoration(
                                hintText: "Money(currency)"),
                            controller: moneyInputController,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                const InputDecoration(hintText: "Amount"),
                            keyboardType: TextInputType.number,
                            controller: moneyAmountInputController,
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
                      Text(
                        Utils().dateTimeToText(_pickedDate),
                      ),
                      IconButton(
                          onPressed: () {
                            showCalender(context);
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FittedBox(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: saveMemo, child: const Text("Save")),
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
