import 'package:get/get.dart';
import '../controllers/reportorder_controller.dart';

class ReportOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportOrderController>(() => ReportOrderController());
  }
}
