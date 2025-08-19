import 'package:get/get.dart';
import '../controllers/expensecategory_controller.dart';

class ExpenseCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseCategoryController>(() => ExpenseCategoryController());
  }
}
