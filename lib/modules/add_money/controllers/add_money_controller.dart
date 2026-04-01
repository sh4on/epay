import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/money_source_item.dart';
import '../../../data/repositories/add_money_repository.dart';

// add money tab types
enum AddMoneyTab { bankToEkpay, cardToEkpay }

class AddMoneyController extends GetxController {
  final AddMoneyRepository _repository;
  AddMoneyController(this._repository);

  // tabs
  final Rx<AddMoneyTab> activeTab = AddMoneyTab.bankToEkpay.obs;

  // page status
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());

  // bank tab sources
  RxList<MoneySourceItem> bankSources = <MoneySourceItem>[].obs;

  // card tab sources
  RxList<MoneySourceItem> cardSources = <MoneySourceItem>[].obs;

  // currently selected source id in bank tab
  final RxString selectedBankSourceId = '1'.obs;

  // currently selected source id in card tab
  final RxString selectedCardSourceId = '1'.obs;

  // processing state
  final RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSources();
  }

  // fetch all source options
  Future<void> fetchSources() async {
    status.value = RxStatus.loading();

    final bankResult = await _repository.fetchBankSources();
    final cardResult = await _repository.fetchCardSources();

    if (bankResult.isSuccess && cardResult.isSuccess) {
      // parse bank sources
      bankSources.value = (bankResult.data as List)
          .map((e) => MoneySourceItem.fromJson(e))
          .toList();

      // parse card sources
      cardSources.value = (cardResult.data as List)
          .map((e) => MoneySourceItem.fromJson(e))
          .toList();

      status.value = RxStatus.success();
    } else {
      status.value = RxStatus.error('Failed to load sources');
    }
  }

  // switch between bank and card tabs
  void switchTab(AddMoneyTab tab) {
    activeTab.value = tab;
  }

  // select a bank source
  void selectBankSource(String id) {
    selectedBankSourceId.value = id;
  }

  // select a card source
  void selectCardSource(String id) {
    selectedCardSourceId.value = id;
  }

  // proceed button tap
  Future<void> onProceedTap() async {
    isProcessing.value = true;

    final result = await _repository.processAddMoney(
      sourceId: activeTab.value == AddMoneyTab.bankToEkpay
          ? selectedBankSourceId.value
          : selectedCardSourceId.value,
      amount: 0,
      type: activeTab.value == AddMoneyTab.bankToEkpay ? 'bank' : 'card',
    );

    isProcessing.value = false;

    if (result.isSuccess) {
      Get.snackbar(
        'Add Money',
        'Proceeding to add money. Next step coming soon.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } else {
      Get.snackbar(
        'Failed',
        result.message ?? 'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }
}
