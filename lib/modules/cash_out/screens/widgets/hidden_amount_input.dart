import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/cash_out_controller.dart';
class HiddenAmountInput extends StatelessWidget {
  final CashOutController controller;

  const HiddenAmountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(controller.amountFocusNode);
        },
        child: Column(
          children: [
            SizedBox(
              width: 1,
              height: 1,
              child: TextField(
                controller: controller.amountTextController,
                focusNode: controller.amountFocusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],

                onChanged: (value) {
                  controller.onAmountChanged(value);
                },

                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(
                  fontSize: 1,
                  color: Colors.transparent,
                ),
              ),
            ),

            Text(
              '',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}