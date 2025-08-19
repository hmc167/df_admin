import 'package:get/get.dart';
import '../controllers/reportdailyorderproduct_controller.dart';

class ReportDailyOrderProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportDailyOrderProductController>(() => ReportDailyOrderProductController());
  }
}
