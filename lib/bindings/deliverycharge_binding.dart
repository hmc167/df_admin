import 'package:get/get.dart';
import '../controllers/deliverycharge_controller.dart';

class DeliveryChargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryChargeController>(() => DeliveryChargeController());
  }
}
