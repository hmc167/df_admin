import 'package:get/get.dart';
import '../controllers/customerinquiry_controller.dart';

class CustomerInquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerInquiryController>(() => CustomerInquiryController());
  }
}
