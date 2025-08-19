import 'package:get/get.dart';
import '../controllers/dailyorders_controller.dart';

class DailyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyOrdersController>(() => DailyOrdersController());
  }
}
