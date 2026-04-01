import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controllers/cash_out_controller.dart';

class HiddenAmountInput extends StatefulWidget {
  final CashOutController controller;

  const HiddenAmountInput({super.key, required this.controller});

  @override
  State<HiddenAmountInput> createState() => _HiddenAmountInputState();
}

class _HiddenAmountInputState extends State<HiddenAmountInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.amountFocusNode = _focusNode;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1,
        height: 1,
        child: TextField(
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: widget.controller.onAmountChanged,
          decoration: const InputDecoration(border: InputBorder.none),
          style: const TextStyle(fontSize: 1, color: Colors.transparent),
        ),
      ),
    );
  }
}
