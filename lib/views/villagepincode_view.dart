import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/villagepincode_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class VillagePincodeView extends StatefulWidget {
  const VillagePincodeView({super.key});

  @override
  State<VillagePincodeView> createState() => _VillagePincodeViewState();
}

class _VillagePincodeViewState extends State<VillagePincodeView> {
  final VillagePincodeController controller = Get.put(
    VillagePincodeController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('VillagePincodeView Screen')),
    );
  }
}
