import 'package:get/get.dart';
import '../../../data/models/user_model.dart';

class BaseController extends GetxController {
  // currently active bottom nav index
  final RxInt activeIndex = 0.obs;

  // logged-in user data passed from auth
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  // balance visibility toggle
  final RxBool isBalanceVisible = true.obs;

  @override
  void onInit() {
    super.onInit();

    // receive user model from auth navigation arguments
    if (Get.arguments != null && Get.arguments is UserModel) {
      user.value = Get.arguments as UserModel;
    } else {
      // fallback mock user
      user.value = const UserModel(
        id: '1',
        name: 'RAHUL',
        phone: '01730805499',
        balance: 13999.00,
        points: 1972,
        avatarUrl: null,
      );
    }
  }

  // switch bottom nav tab
  void onTabChanged(int index) {
    activeIndex.value = index;
  }

  // toggle balance show/hide
  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }

  // format balance for display
  String get formattedBalance {
    return 'Tk: ${user.value?.balance.toStringAsFixed(2) ?? '0.00'}';
  }

  // format points for display
  String get formattedPoints {
    return '${user.value?.points ?? 0} Points';
  }
}