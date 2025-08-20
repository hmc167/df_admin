import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reportusers_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ReportUsersView extends StatefulWidget {
  const ReportUsersView({super.key});

  @override
  State<ReportUsersView> createState() => _ReportUsersViewState();
}

class _ReportUsersViewState extends State<ReportUsersView> {
  final ReportUsersController controller = Get.put(ReportUsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ReportUsersView Screen')),
    );
  }
}
