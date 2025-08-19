import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../routes/app_pages.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    bindDashboard();
  }

  void refreshDashboard() {
    bindDashboard();
  }

  void bindDashboard() {
    // Initialize or bind any necessary services or data for the dashboard
    // For example, you might want to fetch initial data from an API or database
  }
  // var selectedMenu = 'Dashboard'.obs;

  // void selectMenu(String item) {
  //   selectedMenu.value = item;
  // }

  // void logout() async {
  //   await StorageService.clearToken();
  //   Get.offAllNamed(Routes.LOGIN);
  // }
}
