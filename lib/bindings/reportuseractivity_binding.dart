import 'package:get/get.dart';
import '../controllers/reportuseractivity_controller.dart';

class ReportUserActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportUserActivityController>(() => ReportUserActivityController());
  }
}
