import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/deliverycharge_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class DeliveryChargeView extends StatefulWidget {
  const DeliveryChargeView({super.key});

  @override
  State<DeliveryChargeView> createState() => _DeliveryChargeViewState();
}

class _DeliveryChargeViewState extends State<DeliveryChargeView> {
  final DeliveryChargeController controller = Get.put(
    DeliveryChargeController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('DeliveryCharge Screen')),
    );
  }
}
