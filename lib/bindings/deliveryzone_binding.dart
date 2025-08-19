import 'package:get/get.dart';
import '../controllers/deliveryzone_controller.dart';

class DeliveryZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryZoneController>(() => DeliveryZoneController());
  }
}
