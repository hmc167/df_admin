import 'package:get/get.dart';
import '../controllers/reportusers_controller.dart';

class ReportUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportUsersController>(() => ReportUsersController());
  }
}
