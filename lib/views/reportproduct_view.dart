import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportproduct_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportProductView extends StatefulWidget {
  const ReportProductView({super.key});

  @override
  State<ReportProductView> createState() => _ReportProductViewState();
}

class _ReportProductViewState extends State<ReportProductView> {
  final ReportProductController controller = Get.put(ReportProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportProductView Screen')),
    );
  }
}
