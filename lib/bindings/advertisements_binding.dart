import 'package:get/get.dart';
import '../controllers/advertisements_controller.dart';

class AdvertisementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertisementsController>(() => AdvertisementsController());
  }
}
