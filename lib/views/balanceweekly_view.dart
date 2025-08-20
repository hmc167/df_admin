import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/utils/colors.dart';

import '../controllers/balanceweekly_controller.dart';
import '../widgets/appbar.dart';

class BalanceWeeklyView extends StatefulWidget {
  const BalanceWeeklyView({super.key});

  @override
  State<BalanceWeeklyView> createState() => _BalanceWeeklyViewState();
}

class _BalanceWeeklyViewState extends State<BalanceWeeklyView> {
  final BalanceWeeklyController controller = Get.put(BalanceWeeklyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('BalanceWeekly Screen')),
    );
  }
}
