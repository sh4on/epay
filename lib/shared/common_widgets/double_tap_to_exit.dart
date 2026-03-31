import 'package:epay/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DoubleTapToExit extends StatefulWidget {
  const DoubleTapToExit({super.key, required this.child});

  final Widget child;

  @override
  State<DoubleTapToExit> createState() => _DoubleTapToExitState();
}

class _DoubleTapToExitState extends State<DoubleTapToExit> {
  DateTime? _lastBackPressTime;

  Future<bool> _shouldExit() async {
    final now = DateTime.now();

    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;

      Get.snackbar(
        'Exit',
        'Tap again to exit!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),

        borderRadius: 12,
        duration: const Duration(seconds: 2),

        isDismissible: true,
        forwardAnimationCurve: Curves.easeOut,
      );

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          final shouldExit = await _shouldExit();
          if (shouldExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: widget.child,
    );
  }
}