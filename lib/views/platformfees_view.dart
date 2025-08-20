import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/platformfees_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class PlatformFeesView extends StatefulWidget {
  const PlatformFeesView({super.key});

  @override
  State<PlatformFeesView> createState() => _PlatformFeesViewState();
}

class _PlatformFeesViewState extends State<PlatformFeesView> {
  final PlatformFeesController controller = Get.put(PlatformFeesController());
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
