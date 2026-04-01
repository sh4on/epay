import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/models/bank_model.dart';
import '../../../data/repositories/cash_out_repository.dart';
import '../../../routes/app_pages.dart';
import '../screens/widgets/cash_out_success_dialog.dart';

enum CashOutTab { agent, atm }

class CashOutController extends GetxController {
  final CashOutRepository _repository;

  CashOutController(this._repository);

  // tab
  final Rx<CashOutTab> activeTab = CashOutTab.agent.obs;

  // agent tab
  final TextEditingController agentNumberController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  late FocusNode amountFocusNode;

  // contacts load status
  Rx<RxStatus> contactsStatus = Rx<RxStatus>(RxStatus.loading());

  // recent contacts list
  RxList<ContactModel> recentContacts = <ContactModel>[].obs;

  // all contacts list
  RxList<ContactModel> allContacts = <ContactModel>[].obs;

  // ── atm tab
  final TextEditingController bankSearchController = TextEditingController();

  // banks load status
  Rx<RxStatus> banksStatus = Rx<RxStatus>(RxStatus.loading());

  // all partner banks
  RxList<BankModel> partnerBanks = <BankModel>[].obs;

  // filtered banks based on search
  RxList<BankModel> filteredBanks = <BankModel>[].obs;

  // confirm screen
  // selected agent/contact phone
  final RxString selectedPhone = ''.obs;

  // entered amount
  final RxDouble enteredAmount = 0.0.obs;

  // available balance (from user session — mock)
  final double availableBalance = 13999.0;

  // processing state
  final RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
    fetchBanks();

    // live search on bank search field
    bankSearchController.addListener(_onBankSearch);
  }

  // reset amount
  void resetAmount() {
    enteredAmount.value = 0.0;
    if (amountTextController.text.isNotEmpty) {
      amountTextController.clear();
    }
  }

  // switch between agent and atm tabs
  void switchTab(CashOutTab tab) {
    activeTab.value = tab;
  }

  // fetch contacts for agent tab
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

  // contact tapped — fill agent number field
  void onContactTapped(ContactModel contact) {
    agentNumberController.text = contact.phone;
    selectedPhone.value = contact.phone;
  }

  // proceed with agent number
  void onAgentProceed() {
    final phone = agentNumberController.text.trim();
    if (phone.isEmpty) {
      Get.snackbar(
        'Enter Agent Number',
        'Please input an agent number to proceed.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
    selectedPhone.value = phone;
    Get.toNamed(AppRoutes.confirmCashOut);
  }

  // qr scan tap
  void onQrScanTap() {
    Get.snackbar(
      'QR Scan',
      'QR scanner coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // fetch partner banks
  Future<void> fetchBanks() async {
    banksStatus.value = RxStatus.loading();

    final result = await _repository.fetchPartnerBanks();

    if (result.isSuccess) {
      partnerBanks.value = (result.data as List)
          .map((e) => BankModel.fromJson(e))
          .toList();
      filteredBanks.value = partnerBanks;
      banksStatus.value = RxStatus.success();
    } else {
      banksStatus.value = RxStatus.error('Failed to load banks');
    }
  }

  // live filter banks by search query
  void _onBankSearch() {
    final query = bankSearchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredBanks.value = partnerBanks;
    } else {
      filteredBanks.value = partnerBanks
          .where(
            (b) =>
                b.name.toLowerCase().contains(query) ||
                b.branchName.toLowerCase().contains(query),
          )
          .toList();
    }
  }

  // bank card tapped
  void onBankTapped(BankModel bank) {
    Get.snackbar(
      bank.name,
      '${bank.name} - ${bank.branchName} selected.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // update amount from keypad input
  void onAmountChanged(String value) {
    enteredAmount.value = double.tryParse(value) ?? 0.0;
  }

  // confirm cash out
  Future<void> onConfirmTap(BuildContext context) async {
    FocusScope.of(context).unfocus();

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

    final result = await _repository.processCashOut(
      agentPhone: selectedPhone.value,
      amount: enteredAmount.value,
    );

    isProcessing.value = false;

    if (result.isSuccess) {
      // show success dialog
      _showCashOutSuccess(context);
    } else {
      Get.snackbar(
        'Cash Out Failed',
        result.message ?? 'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  // show cash out success dialog
  void _showCashOutSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CashOutSuccessDialog(
        amount: enteredAmount.value,
        onBackToHome: () {
          Get.until((route) => route.settings.name == AppRoutes.base);
        },
      ),
    );
  }
}
