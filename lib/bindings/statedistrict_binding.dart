import 'package:get/get.dart';
import '../controllers/statedistrict_controller.dart';

class StateDistrictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StateDistrictController>(() => StateDistrictController());
  }
}
