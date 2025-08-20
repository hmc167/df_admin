import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/utils/colors.dart';

import '../controllers/balancedaterange_controller.dart';
import '../widgets/appbar.dart';

class BalanceDateRangeView extends StatefulWidget {
  const BalanceDateRangeView({super.key});

  @override
  State<BalanceDateRangeView> createState() => _BalanceDateRangeViewState();
}

class _BalanceDateRangeViewState extends State<BalanceDateRangeView> {
  final BalanceDateRangeController controller = Get.put(
    BalanceDateRangeController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('BalanceDateRange Screen')),
    );
  }
}
