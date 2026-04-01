import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controllers/send_money_controller.dart';

class AmountInputField extends StatelessWidget {
  final SendMoneyController controller;

  const AmountInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1,
        height: 1,
        child: TextField(
          focusNode: controller.amountFocusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: controller.onAmountChanged,
          decoration: const InputDecoration(border: InputBorder.none),
          style: const TextStyle(fontSize: 1, color: Colors.transparent),
        ),
      ),
    );
  }
}
