import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dailyorders_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class DailyOrdersView extends StatefulWidget {
  const DailyOrdersView({super.key});

  @override
  State<DailyOrdersView> createState() => _DailyOrdersViewState();
}

class _DailyOrdersViewState extends State<DailyOrdersView> {
  final DailyOrdersController controller = Get.put(DailyOrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('DailyOrders Screen')),
    );
  }
}
