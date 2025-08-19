import 'package:get/get.dart';
import '../controllers/reportdailyfarmersaccount_controller.dart';

class ReportDailyFarmersAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportDailyFarmersAccountController>(() => ReportDailyFarmersAccountController());
  }
}
