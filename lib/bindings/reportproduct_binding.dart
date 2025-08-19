import 'package:get/get.dart';
import '../controllers/reportproduct_controller.dart';

class ReportProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportProductController>(() => ReportProductController());
  }
}
