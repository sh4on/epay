import 'package:epay/core/utils/extensions/context_extensions.dart';
import 'package:epay/modules/splash/screens/widgets/decorative_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A3A8C),
              Color(0xFF2B5FCC),
              Color(0xFFAEC6F0),
              Color(0xFFD6E4F7),
              Color(0xFFAEC6F0),
              Color(0xFF2B5FCC),
              Color(0xFF1A3A8C),
            ],
            stops: [0.0, 0.15, 0.38, 0.5, 0.62, 0.85, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // top-left decorative blob
            Positioned(
              top: -context.screenWidth * 0.3,
              left: -context.screenWidth * 0.2,
              child: DecorativeCircle(
                size: context.screenWidth * 0.75,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),

            // top-right decorative blob
            Positioned(
              top: context.screenHeight * 0.05,
              right: -context.screenWidth * 0.25,
              child: DecorativeCircle(
                size: context.screenWidth * 0.65,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),

            // bottom-left decorative blob
            Positioned(
              bottom: context.screenWidth * 0.05,
              left: -context.screenWidth * 0.25,
              child: DecorativeCircle(
                size: context.screenWidth * 0.65,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),

            // bottom-right decorative blob
            Positioned(
              bottom: -context.screenWidth * 0.3,
              right: -context.screenWidth * 0.2,
              child: DecorativeCircle(
                size: context.screenWidth * 0.75,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),

            // centered logo
            Center(child: SvgPicture.asset(Assets.splash.splashLogo)),
          ],
        ),
      ),
    );
  }
}
