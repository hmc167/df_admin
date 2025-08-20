import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportorder_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportOrderView extends StatefulWidget {
  const ReportOrderView({super.key});

  @override
  State<ReportOrderView> createState() => _ReportOrderViewState();
}

class _ReportOrderViewState extends State<ReportOrderView> {
  final ReportOrderController controller = Get.put(ReportOrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportOrderView Screen')),
    );
  }
}
