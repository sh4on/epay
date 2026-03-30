import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/repositories/send_money_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class SendMoneyController extends GetxController {
  final SendMoneyRepository _repository;
  SendMoneyController(this._repository);

  // ── contacts ──────────────────────────────────────────────────────────────

  // contacts load status
  Rx<RxStatus> contactsStatus = Rx<RxStatus>(RxStatus.loading());

  // recent contacts
  RxList<ContactModel> recentContacts = <ContactModel>[].obs;

  // all contacts
  RxList<ContactModel> allContacts = <ContactModel>[].obs;

  // ── input ─────────────────────────────────────────────────────────────────

  // search / number input controller
  final TextEditingController searchController = TextEditingController();

  // whether user has typed something
  final RxBool hasInput = false.obs;

  // ── confirm screen ────────────────────────────────────────────────────────

  // selected recipient phone
  final RxString selectedPhone = ''.obs;

  // entered amount
  final RxDouble enteredAmount = 0.0.obs;

  // available balance (mock — replace with real user session value)
  final double availableBalance = 13999.0;

  // processing state
  final RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();

    // fetch contacts on load
    fetchContacts();

    // listen to search field changes
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // fetch recent and all contacts
  Future<void> fetchContacts() async {
    contactsStatus.value = RxStatus.loading();

    final recentResult = await _repository.fetchRecentContacts();
    final allResult = await _repository.fetchAllContacts();

    if (recentResult.isSuccess && allResult.isSuccess) {
      recentContacts.value = (recentResult.data as List)
          .map((e) => ContactModel.fromJson(e))
          .toList();

      allContacts.value = (allResult.data as List)
          .map((e) => ContactModel.fromJson(e))
          .toList();

      contactsStatus.value = RxStatus.success();
    } else {
      contactsStatus.value = RxStatus.error('Failed to load contacts');
    }
  }

  // update hasInput flag when search field changes
  void _onSearchChanged() {
    hasInput.value = searchController.text.trim().isNotEmpty;
    selectedPhone.value = searchController.text.trim();
  }

  // contact tapped — fill input field
  void onContactTapped(ContactModel contact) {
    searchController.text = contact.phone;
    selectedPhone.value = contact.phone;
    hasInput.value = true;
  }

  // proceed to confirm send money screen
  void onProceed() {
    final phone = searchController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar(
        'Enter Number',
        'Please enter a name or number to proceed.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
    selectedPhone.value = phone;
    Get.toNamed(AppRoutes.confirmSendMoney);
  }

  // ── confirm screen methods ────────────────────────────────────────────────

  // update amount from input
  void onAmountChanged(String value) {
    enteredAmount.value = double.tryParse(value) ?? 0.0;
  }

  // confirm send money
  Future<void> onConfirmTap(BuildContext context) async {
    if (enteredAmount.value <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (enteredAmount.value > availableBalance) {
      Get.snackbar(
        'Insufficient Balance',
        'You do not have enough balance.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isProcessing.value = true;

    final result = await _repository.processSendMoney(
      recipientPhone: selectedPhone.value,
      amount: enteredAmount.value,
    );

    isProcessing.value = false;

    if (result.isSuccess) {
      // show send money success dialog
      _showSendMoneySuccess(context);
    } else {
      Get.snackbar(
        'Send Money Failed',
        result.message ?? 'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  // show send money success dialog
  void _showSendMoneySuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SendMoneySuccessDialog(
        amount: enteredAmount.value,
        onBackToHome: () {
          // pop back to base screen
          Get.until((route) => route.settings.name == AppRoutes.base);
        },
      ),
    );
  }
}

// ─── send money success dialog ────────────────────────────────────────────────

class _SendMoneySuccessDialog extends StatelessWidget {
  final double amount;
  final VoidCallback onBackToHome;

  const _SendMoneySuccessDialog({
    required this.amount,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // flying coins illustration
            _SendMoneyIllustration(),

            const SizedBox(height: 16),

            // success title
            const Text(
              'Send Money Successful',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),

            const SizedBox(height: 12),

            // success message with highlighted amount
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A8A9A),
                ),
                children: [
                  const TextSpan(text: 'You have successfully\nSend '),
                  TextSpan(
                    text: 'TK ${amount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Color(0xFFF5A623),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // back to home button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onBackToHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2E6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Back To Home',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── send money illustration — two hands with phones, flying coins ────────────

class _SendMoneyIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 130,
      child: CustomPaint(painter: _SendMoneyPainter()),
    );
  }
}

class _SendMoneyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── left phone (sender — green up arrow) ──────────────────────────────

    _drawPhone(
      canvas: canvas,
      center: Offset(w * 0.22, h * 0.58),
      width: 38,
      height: 62,
      bodyColor: const Color(0xFF1A2E6C),
      screenColor: const Color(0xFF2B9348),
      arrowUp: true,
    );

    // left hand holding phone
    _drawHand(canvas, Offset(w * 0.22, h * 0.82), true);

    // ── right phone (receiver — green checkmark) ───────────────────────────

    _drawPhone(
      canvas: canvas,
      center: Offset(w * 0.78, h * 0.58),
      width: 38,
      height: 62,
      bodyColor: const Color(0xFF1A2E6C),
      screenColor: const Color(0xFF2B9348),
      arrowUp: false,
    );

    // right hand holding phone
    _drawHand(canvas, Offset(w * 0.78, h * 0.82), false);

    // ── flying coins ──────────────────────────────────────────────────────

    // coin positions — arc between the two phones
    final coinPositions = [
      Offset(w * 0.28, h * 0.14),
      Offset(w * 0.50, h * 0.06),
      Offset(w * 0.72, h * 0.14),
    ];

    for (final pos in coinPositions) {
      _drawCoin(canvas, pos, 14);
    }
  }

  // draw a simplified phone shape
  void _drawPhone({
    required Canvas canvas,
    required Offset center,
    required double width,
    required double height,
    required Color bodyColor,
    required Color screenColor,
    required bool arrowUp,
  }) {
    final bodyPaint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill;

    // phone body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      const Radius.circular(8),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // screen area
    final screenPaint = Paint()
      ..color = screenColor
      ..style = PaintingStyle.fill;

    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - 4),
        width: width - 8,
        height: height - 20,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(screenRect, screenPaint);

    // icon on screen — arrow up or checkmark
    final iconPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (arrowUp) {
      // up arrow (sender)
      final arrowPath = Path()
        ..moveTo(center.dx, center.dy - 16)
        ..lineTo(center.dx, center.dy + 2)
        ..moveTo(center.dx - 7, center.dy - 9)
        ..lineTo(center.dx, center.dy - 16)
        ..lineTo(center.dx + 7, center.dy - 9);
      canvas.drawPath(arrowPath, iconPaint);

      // horizontal lines below arrow
      canvas.drawLine(
        Offset(center.dx - 8, center.dy + 6),
        Offset(center.dx + 8, center.dy + 6),
        iconPaint..strokeWidth = 2,
      );
      canvas.drawLine(
        Offset(center.dx - 6, center.dy + 11),
        Offset(center.dx + 6, center.dy + 11),
        iconPaint,
      );
    } else {
      // checkmark (receiver)
      iconPaint.strokeWidth = 2.5;
      final checkPath = Path()
        ..moveTo(center.dx - 9, center.dy - 4)
        ..lineTo(center.dx - 2, center.dy + 4)
        ..lineTo(center.dx + 10, center.dy - 10);
      canvas.drawPath(checkPath, iconPaint);
    }

    // home button dot at bottom of phone
    final dotPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(center.dx, center.dy + height / 2 - 7),
      3,
      dotPaint,
    );
  }

  // draw a simplified holding hand
  void _drawHand(Canvas canvas, Offset center, bool isLeft) {
    final handPaint = Paint()
      ..color = const Color(0xFFD4956A)
      ..style = PaintingStyle.fill;

    // palm shape
    final palmPath = Path()
      ..moveTo(center.dx - 16, center.dy)
      ..quadraticBezierTo(
        center.dx - 18,
        center.dy + 20,
        center.dx - 8,
        center.dy + 26,
      )
      ..lineTo(center.dx + 8, center.dy + 26)
      ..quadraticBezierTo(
        center.dx + 18,
        center.dy + 20,
        center.dx + 16,
        center.dy,
      )
      ..close();

    canvas.drawPath(palmPath, handPaint);

    // thumb
    final thumbPaint = Paint()
      ..color = const Color(0xFFD4956A)
      ..style = PaintingStyle.fill;

    final thumbOffset = isLeft
        ? Offset(center.dx - 22, center.dy + 4)
        : Offset(center.dx + 22, center.dy + 4);

    canvas.drawOval(
      Rect.fromCenter(center: thumbOffset, width: 14, height: 10),
      thumbPaint,
    );
  }

  // draw a coin with dollar sign
  void _drawCoin(Canvas canvas, Offset center, double radius) {
    // gold filled circle
    final coinFill = Paint()
      ..color = const Color(0xFFF5A623)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, coinFill);

    // slightly darker ring
    final coinRing = Paint()
      ..color = const Color(0xFFD4891A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, coinRing);

    // dollar sign
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '\$',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}