import 'package:get/get.dart';
import '../controllers/newarrival_controller.dart';

class NewArrivalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewArrivalController>(() => NewArrivalController());
  }
}
