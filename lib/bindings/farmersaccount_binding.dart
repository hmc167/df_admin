import 'package:get/get.dart';
import '../controllers/farmersaccount_controller.dart';

class FarmersAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmersAccountController>(() => FarmersAccountController());
  }
}
