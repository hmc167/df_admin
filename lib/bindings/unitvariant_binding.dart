import 'package:get/get.dart';
import '../controllers/unitvariant_controller.dart';

class UnitVariantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnitVariantController>(() => UnitVariantController());
  }
}
