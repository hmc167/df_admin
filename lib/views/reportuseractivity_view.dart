import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportuseractivity_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportUserActivityView extends StatefulWidget {
  const ReportUserActivityView({super.key});

  @override
  State<ReportUserActivityView> createState() => _ReportUserActivityViewState();
}

class _ReportUserActivityViewState extends State<ReportUserActivityView> {
  final ReportUserActivityController controller = Get.put(
    ReportUserActivityController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportUserActivityView Screen')),
    );
  }
}
