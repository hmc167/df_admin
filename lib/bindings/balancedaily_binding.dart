import 'package:get/get.dart';
import '../controllers/balancedaily_controller.dart';

class BalanceDailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceDailyController>(() => BalanceDailyController());
  }
}
