import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/repositories/send_money_repository.dart';
import '../../../routes/app_pages.dart';
import '../screens/widgets/send_money_success_dialog.dart';

class SendMoneyController extends GetxController {
  final SendMoneyRepository _repository;

  SendMoneyController(this._repository);

  // contacts load status
  Rx<RxStatus> contactsStatus = Rx<RxStatus>(RxStatus.loading());

  // recent contacts
  RxList<ContactModel> recentContacts = <ContactModel>[].obs;

  // all contacts
  RxList<ContactModel> allContacts = <ContactModel>[].obs;

  // input

  // search / number input controller
  final TextEditingController searchController = TextEditingController();

  // whether user has typed something
  final RxBool hasInput = false.obs;

  // confirm screen

  // selected recipient phone
  final RxString selectedPhone = ''.obs;

  // entered amount
  final RxDouble enteredAmount = 0.0.obs;

  // available balance
  final double availableBalance = 13999.0;

  // processing state
  final RxBool isProcessing = false.obs;

  final FocusNode amountFocusNode = FocusNode();

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
    amountFocusNode.dispose();
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
      builder: (_) => SendMoneySuccessDialog(
        amount: enteredAmount.value,
        onBackToHome: () {
          // pop back to base screen
          Get.until((route) => route.settings.name == AppRoutes.base);
        },
      ),
    );
  }
}
