import 'package:get/get.dart';
import '../controllers/reportexpenses_controller.dart';

class ReportExpensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportExpensesController>(() => ReportExpensesController());
  }
}
