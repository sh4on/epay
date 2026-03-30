import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              top: -size.width * 0.3,
              left: -size.width * 0.2,
              child: _DecorativeCircle(
                size: size.width * 0.75,
                color: Colors.white.withOpacity(0.07),
              ),
            ),

            // top-right decorative blob
            Positioned(
              top: size.height * 0.05,
              right: -size.width * 0.25,
              child: _DecorativeCircle(
                size: size.width * 0.65,
                color: Colors.white.withOpacity(0.06),
              ),
            ),

            // bottom-left decorative blob
            Positioned(
              bottom: size.height * 0.05,
              left: -size.width * 0.25,
              child: _DecorativeCircle(
                size: size.width * 0.65,
                color: Colors.white.withOpacity(0.06),
              ),
            ),

            // bottom-right decorative blob
            Positioned(
              bottom: -size.width * 0.3,
              right: -size.width * 0.2,
              child: _DecorativeCircle(
                size: size.width * 0.75,
                color: Colors.white.withOpacity(0.07),
              ),
            ),

            // centered logo
            Center(
              child: _SplashLogo(),
            ),
          ],
        ),
      ),
    );
  }
}

// animated logo widget
class _SplashLogo extends StatefulWidget {
  @override
  State<_SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<_SplashLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // fade in
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    // scale up slightly
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: _EPayLogoIcon(),
      ),
    );
  }
}

// epay logo drawn with custom paint — matches the "e" with orange dot design
class _EPayLogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: _EPayLogoPainter(),
      ),
    );
  }
}

class _EPayLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.width * 0.42;
    final double strokeW = size.width * 0.11;

    // arc paint — navy blue ring
    final arcPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    // draw the open "c" arc (270° sweep, leaving gap at top-right)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      -2.2, // start angle (slightly past top)
      5.0,  // sweep angle (almost full circle)
      false,
      arcPaint,
    );

    // orange dot — accent mark at gap end
    final dotPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;

    // position dot at top-right of arc opening
    final dotX = cx + radius * 0.62;
    final dotY = cy - radius * 0.70;
    canvas.drawCircle(
      Offset(dotX, dotY),
      strokeW * 0.52,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// decorative translucent circle for background blobs
class _DecorativeCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}