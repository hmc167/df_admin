import 'package:get/get.dart';
import '../controllers/balancedaterange_controller.dart';

class BalanceDateRangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceDateRangeController>(() => BalanceDateRangeController());
  }
}
