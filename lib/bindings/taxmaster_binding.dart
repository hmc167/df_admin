import 'package:get/get.dart';
import '../controllers/taxmaster_controller.dart';

class TaxMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaxMasterController>(() => TaxMasterController());
  }
}
