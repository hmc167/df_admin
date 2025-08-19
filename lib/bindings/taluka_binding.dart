import 'package:get/get.dart';
import '../controllers/taluka_controller.dart';

class TalukaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TalukaController>(() => TalukaController());
  }
}
