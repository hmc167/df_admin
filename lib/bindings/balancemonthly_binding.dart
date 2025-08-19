import 'package:get/get.dart';
import '../controllers/balancemonthly_controller.dart';

class BalanceMonthlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceMonthlyController>(() => BalanceMonthlyController());
  }
}
