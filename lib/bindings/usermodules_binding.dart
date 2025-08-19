import 'package:get/get.dart';
import '../controllers/usermodules_controller.dart';

class UserModulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserModulesController>(() => UserModulesController());
  }
}
