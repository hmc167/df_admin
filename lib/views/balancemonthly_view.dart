import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/utils/colors.dart';

import '../controllers/balancemonthly_controller.dart';
import '../widgets/appbar.dart';

class BalanceMonthlyView extends StatefulWidget {
  const BalanceMonthlyView({super.key});

  @override
  State<BalanceMonthlyView> createState() => _BalanceMonthlyViewState();
}

class _BalanceMonthlyViewState extends State<BalanceMonthlyView> {
  final BalanceMonthlyController controller = Get.put(
    BalanceMonthlyController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('BalanceMonthly Screen')),
    );
  }
}
