import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/dashboard_summery.dart';
import '../services/api_service_login.dart';

class DashboardController extends GetxController {

  var dashboardData = DashboardData().obs;

  @override
  void onInit() {
    super.onInit();
    bindDashboard();
  }

  void refreshDashboard() {
    bindDashboard();
  }

  Future<void> bindDashboard() async {
     var result = await ApiServiceLogin.getDashboardSummary();
    if (result.hasError == false) {
      dashboardData.value = result.data!;
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching dashboard data.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }
}
