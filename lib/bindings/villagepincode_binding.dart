import 'package:get/get.dart';
import '../controllers/villagepincode_controller.dart';

class VillagePincodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillagePincodeController>(() => VillagePincodeController());
  }
}
