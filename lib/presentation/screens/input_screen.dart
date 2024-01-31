import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/utils.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late TextEditingController guestNameInputController;
  late TextEditingController giftInputController;
  late TextEditingController moneyAmountInputController;
  late TextEditingController giftAmountInputController;
  GuestGender _selectedGender = GuestGender.male;
  void saveMemo() {
    //Error Handling & Dealing With Null
    if (giftInputController.text == "") {
      giftInputController.text = "Gift";
    }
    if (guestNameInputController.text == "") {
      CustomWidgetsUtils().invalidInputPop(context, Values.blankInputMessage);
      return;
    }
    final double moneyAmount =
        double.tryParse(moneyAmountInputController.text) ?? 0.0;
    final int giftAmount = int.tryParse(giftAmountInputController.text) ?? 0;

    if (guestNameInputController.text == "" ||
        giftAmount < 0 ||
        moneyAmount < 0) {
      CustomWidgetsUtils().invalidInputPop(context, Values.invalidValue);
      return;
    }

    if (giftAmount == 0 && moneyAmount == 0) {
      CustomWidgetsUtils().invalidInputPop(
          context, "Pls give any amount >0 in gift amount or money amount");
      return;
    }

    //Adding Records

    final provider = Provider.of<GiftMemoManager>(context, listen: false);

    Utils().addUpdateRecord(
        provider,
        giftAmount,
        moneyAmount,
        context,
        guestNameInputController.text,
        giftInputController.text,
        _selectedGender);
  }

  void editscreenInputInit() {
    if (Values.currentMemoModel != null) {
      guestNameInputController.text = Values.currentMemoModel!.name;
      giftInputController.text = Values.currentMemoModel!.gift.giftName;
      giftAmountInputController.text =
          Values.currentMemoModel!.gift.giftAmount.toString();
      moneyAmountInputController.text =
          Values.currentMemoModel!.gift.moneyAmount.toString();

      _selectedGender = Values.currentMemoModel!.gender;
    }
  }

  @override
  void initState() {
    guestNameInputController = TextEditingController();
    giftInputController = TextEditingController();
    moneyAmountInputController = TextEditingController();
    giftAmountInputController = TextEditingController();

    // for edit screen
    editscreenInputInit();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    guestNameInputController.dispose();
    giftInputController.dispose();
    moneyAmountInputController.dispose();
    giftAmountInputController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (Values.currentMemoModel == null) ? "Add Record" : "Update Record"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            guestProfileInput(),
            const SizedBox(
              height: 30,
            ),
            giftInputs(context),
          ],
        ),
      ),
    );
  }

  Flexible guestProfileInput() {
    return Flexible(
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: const InputDecoration(labelText: "Name"),
              controller: guestNameInputController,
            ),
          ),
          DropdownButton(
              value: _selectedGender,
              items: GuestGender.values
                  .map((ge) => DropdownMenuItem(
                      value: ge, child: Text(ge.name.toUpperCase())))
                  .toList(),
              onChanged: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _selectedGender = val;
                });
              })
        ],
      ),
    );
  }

  Flexible giftInputs(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Gift "),
                    controller: giftInputController,
                  ),
                ),
                const Spacer(),
                const Text("Amount"),
                const SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(hintText: "0"),
                    keyboardType: TextInputType.number,
                    controller: giftAmountInputController,
                    onChanged: (amt) {
                      int amount = int.tryParse(amt) ?? 0;
                      giftAmountInputController.text = amount.toString();
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
                const Flexible(child: Text("Money amount")),
                const SizedBox(
                  width: 30,
                ),
                Flexible(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "0"),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: saveMemo, child: const Text("Save")),
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
    );
  }
}
