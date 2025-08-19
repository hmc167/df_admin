import 'package:get/get.dart';
import '../controllers/platformfees_controller.dart';

class PlatformFeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlatformFeesController>(() => PlatformFeesController());
  }
}
