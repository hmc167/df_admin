import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reportdailyfarmersaccount_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportDailyFarmersAccountView extends StatefulWidget {
  const ReportDailyFarmersAccountView({super.key});

  @override
  State<ReportDailyFarmersAccountView> createState() =>
      _ReportDailyFarmersAccountViewState();
}

class _ReportDailyFarmersAccountViewState
    extends State<ReportDailyFarmersAccountView> {
  final ReportDailyFarmersAccountController controller = Get.put(
    ReportDailyFarmersAccountController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportDailyFarmersAccountView Screen')),
    );
  }
}
