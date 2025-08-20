import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/deliveryzone_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class DeliveryZoneView extends StatefulWidget {
  const DeliveryZoneView({super.key});

  @override
  State<DeliveryZoneView> createState() => _DeliveryZoneViewState();
}

class _DeliveryZoneViewState extends State<DeliveryZoneView> {
  final DeliveryZoneController controller = Get.put(DeliveryZoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('DeliveryZone Screen')),
    );
  }
}
