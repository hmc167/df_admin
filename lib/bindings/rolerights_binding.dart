import 'package:get/get.dart';
import '../controllers/rolerights_controller.dart';

class RoleRightsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleRightsController>(() => RoleRightsController());
  }
}
