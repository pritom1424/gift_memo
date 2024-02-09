import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_memo/core/converters/converters.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/bloc/bloc/giftmemo_bloc.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/invalid_input_pop.dart';
import 'package:gift_memo/main.dart';

const String blankInputMessage =
    "Fix any blank guest name, gift title, money currency, amounts";
const String invalidValue =
    "Fix any negative or invalid gift amount, money amount";

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
  final currentMem = GenericVariables.currentGiftMemo;
  void saveMemo(BuildContext ctx) {
    //Error Handling & Dealing With Null
    if (giftInputController.text == "") {
      giftInputController.text = "Gift";
    }
    if (guestNameInputController.text == "") {
      InvalidInputPop().invalidInputPop(context, blankInputMessage);
      return;
    }
    final double moneyAmount =
        double.tryParse(moneyAmountInputController.text) ?? 0.0;
    final int giftAmount = int.tryParse(giftAmountInputController.text) ?? 0;

    if (guestNameInputController.text == "" ||
        giftAmount < 0 ||
        moneyAmount < 0) {
      InvalidInputPop().invalidInputPop(context, invalidValue);
      return;
    }

    if (giftAmount == 0 && moneyAmount == 0) {
      InvalidInputPop().invalidInputPop(
          context, "Pls give any amount >0 in gift amount or money amount");
      return;
    }

    //Adding Records
    final blocProvider = BlocProvider.of<GiftMemoBloc>(ctx);

    GiftMemo newMemo = GiftMemo(
        id: uuid.v4(),
        name: guestNameInputController.text,
        gift: Gift(
          giftName: giftInputController.text,
          giftAmount: giftAmount,
          moneyAmount: moneyAmount,
          gType: AmountsToTypeConverter(
                  giftAmount: giftAmount, moneyAmount: moneyAmount)
              .inputAmountsToGiftType,
        ),
        gender: _selectedGender,
        date: DateTime.now());

    if (currentMem != null) {
      GiftMemo updateMemo = GiftMemo(
          id: currentMem!.id,
          name: newMemo.name,
          gift: newMemo.gift,
          gender: newMemo.gender,
          date: currentMem!.date);

      blocProvider.add(
          UpdateMemoFromListEvent(id: currentMem!.id, giftMemo: updateMemo));
    } else {
      blocProvider.add(AddMemoToListEvent(giftMemo: newMemo));
    }

    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
  }

  void editscreenInputInit() {
    if (currentMem != null) {
      guestNameInputController.text = currentMem!.name;
      giftInputController.text = currentMem!.gift.giftName;
      giftAmountInputController.text = currentMem!.gift.giftAmount.toString();
      moneyAmountInputController.text = currentMem!.gift.moneyAmount.toString();

      _selectedGender = currentMem!.gender;
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
          title: Text((currentMem == null) ? "Add Record" : "Update Record"),
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
        ));
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

  Flexible giftInputs(BuildContext ctx) {
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
                ElevatedButton(
                    onPressed: () => saveMemo(ctx), child: const Text("Save")),
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
