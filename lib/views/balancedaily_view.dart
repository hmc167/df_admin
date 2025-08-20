import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/utils/colors.dart';

import '../controllers/balancedaily_controller.dart';
import '../widgets/appbar.dart';

class BalanceDailyView extends StatefulWidget {
  const BalanceDailyView({super.key});

  @override
  State<BalanceDailyView> createState() => _BalanceDailyViewState();
}

class _BalanceDailyViewState extends State<BalanceDailyView> {
  final BalanceDailyController controller = Get.put(BalanceDailyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('BalanceDaily Screen')),
    );
  }
}
