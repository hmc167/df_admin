import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reportcustomer_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportCustomerView extends StatefulWidget {
  const ReportCustomerView({super.key});

  @override
  State<ReportCustomerView> createState() => _ReportCustomerViewState();
}

class _ReportCustomerViewState extends State<ReportCustomerView> {
  final ReportCustomerController controller = Get.put(
    ReportCustomerController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportCustomerView Screen')),
    );
  }
}
