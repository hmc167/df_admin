import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportexpenses_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportExpensesView extends StatefulWidget {
  const ReportExpensesView({super.key});

  @override
  State<ReportExpensesView> createState() => _ReportExpensesViewState();
}

class _ReportExpensesViewState extends State<ReportExpensesView> {
  final ReportExpensesController controller = Get.put(
    ReportExpensesController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportExpensesView Screen')),
    );
  }
}
