import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../routes/app_pages.dart';

// service item model for grid display
class ServiceItem {
  final String id;
  final String label;
  final String icon;
  final String route;

  const ServiceItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    icon: json['icon'] ?? '',
    route: json['route'] ?? '',
  );
}

// bill item model
class BillItem {
  final String id;
  final String label;
  final String icon;

  const BillItem({required this.id, required this.label, required this.icon});

  factory BillItem.fromJson(Map<String, dynamic> json) => BillItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    icon: json['icon'] ?? '',
  );
}

// remittance partner model
class RemittanceItem {
  final String id;
  final String label;
  final String logo;

  const RemittanceItem({
    required this.id,
    required this.label,
    required this.logo,
  });

  factory RemittanceItem.fromJson(Map<String, dynamic> json) => RemittanceItem(
    id: json['id'] ?? '',
    label: json['label'] ?? '',
    logo: json['logo'] ?? '',
  );
}

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  // page status
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());

  // service grid items (first 4 shown, rest on see more)
  RxList<ServiceItem> services = <ServiceItem>[].obs;

  // bill items
  RxList<BillItem> billServices = <BillItem>[].obs;

  // remittance partners
  RxList<RemittanceItem> remittanceItems = <RemittanceItem>[].obs;

  // whether extended services are shown
  final RxBool showAllServices = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  // fetch all home screen data
  Future<void> fetchHomeData() async {
    status.value = RxStatus.loading();

    final servicesResult = await _repository.fetchServices();
    final billResult = await _repository.fetchBillServices();
    final remittanceResult = await _repository.fetchRemittance();

    if (servicesResult.isSuccess &&
        billResult.isSuccess &&
        remittanceResult.isSuccess) {
      // parse services
      services.value = (servicesResult.data as List)
          .map((e) => ServiceItem.fromJson(e))
          .toList();

      // parse bill items
      billServices.value = (billResult.data as List)
          .map((e) => BillItem.fromJson(e))
          .toList();

      // parse remittance partners
      remittanceItems.value = (remittanceResult.data as List)
          .map((e) => RemittanceItem.fromJson(e))
          .toList();

      status.value = RxStatus.success();
    } else {
      status.value = RxStatus.error('Failed to load home data');
    }
  }

  // toggle see more / see less for services
  void toggleSeeMoreServices() {
    showAllServices.value = !showAllServices.value;
  }

  // handle service item tap
  void onServiceTap(ServiceItem item) {
    switch (item.icon) {
      case 'cash_out':
        Get.toNamed(AppRoutes.cashOut);
        break;
      case 'send_money':
        Get.toNamed(AppRoutes.sendMoney);
        break;
      case 'add_money':
        Get.toNamed(AppRoutes.addMoney);
        break;
      default:
        // placeholder for other services
        Get.snackbar(
          item.label,
          '${item.label} coming soon.',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
    }
  }

  // handle bill item tap
  void onBillTap(BillItem item) {
    Get.snackbar(
      item.label,
      '${item.label} payment coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
