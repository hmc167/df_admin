import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportfarmersaccount_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportFarmersAccountView extends StatefulWidget {
  const ReportFarmersAccountView({super.key});

  @override
  State<ReportFarmersAccountView> createState() =>
      _ReportFarmersAccountViewState();
}

class _ReportFarmersAccountViewState extends State<ReportFarmersAccountView> {
  final ReportFarmersAccountController controller = Get.put(
    ReportFarmersAccountController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportFarmersAccountView Screen')),
    );
  }
}
