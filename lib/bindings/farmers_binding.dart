import 'package:get/get.dart';
import '../controllers/farmers_controller.dart';

class FarmersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmersController>(() => FarmersController());
  }
}
