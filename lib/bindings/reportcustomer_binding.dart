import 'package:get/get.dart';
import '../controllers/reportcustomer_controller.dart';

class ReportCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportCustomerController>(() => ReportCustomerController());
  }
}
