import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../controllers/otp_controller.dart';
import '../otp_screen.dart';
import 'otp_box.dart';

class OtpBoxRow extends StatelessWidget {
  final OtpController controller;

  const OtpBoxRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: OtpBox(
            textController: controller.otpControllers[index],
            focusNode: controller.focusNodes[index],
            onChanged: (val) => controller.onOtpDigitChanged(index, val),
          ),
        );
      }),
    );
  }
}