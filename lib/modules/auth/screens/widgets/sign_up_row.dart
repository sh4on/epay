import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/login_controller.dart';

class SignUpRow extends StatelessWidget {
  final LoginController controller;

  const SignUpRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('${AppStrings.dontHaveAccount} ', style: AppTypography.bodyMedium),
        GestureDetector(
          onTap: controller.onSignUpTap,
          child: const Text(AppStrings.signUp, style: AppTypography.link),
        ),
      ],
    );
  }
}
