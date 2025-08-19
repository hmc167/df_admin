import 'package:get/get.dart';
import '../controllers/reportfarmersaccount_controller.dart';

class ReportFarmersAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportFarmersAccountController>(() => ReportFarmersAccountController());
  }
}
