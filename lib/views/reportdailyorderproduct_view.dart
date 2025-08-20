import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportdailyorderproduct_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportDailyOrderProductView extends StatefulWidget {
  const ReportDailyOrderProductView({super.key});

  @override
  State<ReportDailyOrderProductView> createState() =>
      _ReportDailyOrderProductViewState();
}

class _ReportDailyOrderProductViewState
    extends State<ReportDailyOrderProductView> {
  final ReportDailyOrderProductController controller = Get.put(
    ReportDailyOrderProductController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportDailyOrderProductView Screen')),
    );
  }
}
