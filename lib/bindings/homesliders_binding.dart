import 'package:get/get.dart';
import '../controllers/homesliders_controller.dart';

class HomeSlidersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSlidersController>(() => HomeSlidersController());
  }
}
