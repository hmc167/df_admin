import 'package:get/get.dart';
import '../controllers/suggestsproduct_controller.dart';

class SuggestsProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestsProductController>(() => SuggestsProductController());
  }
}
