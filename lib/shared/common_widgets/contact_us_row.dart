import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/constants/app_typography.dart';

class ContactUsRow extends StatelessWidget {
  const ContactUsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('${AppStrings.didYouFaceIssue} ', style: AppTypography.bodyMedium),
        GestureDetector(
          onTap: () {},
          child: const Text(AppStrings.contactUs, style: AppTypography.link),
        ),
      ],
    );
  }
}
