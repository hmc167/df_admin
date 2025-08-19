import 'package:get/get.dart';
import '../controllers/balanceweekly_controller.dart';

class BalanceWeeklyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceWeeklyController>(() => BalanceWeeklyController());
  }
}
