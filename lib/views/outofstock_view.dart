import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/outofstock_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class OutOfStockView extends StatefulWidget {
  const OutOfStockView({super.key});

  @override
  State<OutOfStockView> createState() => _OutOfStockViewState();
}

class _OutOfStockViewState extends State<OutOfStockView> {
  final OutOfStockController controller = Get.put(OutOfStockController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('HomeSlidersView Screen')),
    );
  }
}
