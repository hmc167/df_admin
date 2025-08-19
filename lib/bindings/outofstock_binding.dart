import 'package:get/get.dart';
import '../controllers/outofstock_controller.dart';

class OutOfStockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutOfStockController>(() => OutOfStockController());
  }
}
