import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rolerights_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class RoleRightsView extends StatefulWidget {
  const RoleRightsView({super.key});

  @override
  State<RoleRightsView> createState() => _RoleRightsViewState();
}

class _RoleRightsViewState extends State<RoleRightsView> {
  final RoleRightsController controller = Get.put(RoleRightsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('RoleRightsView Screen')),
    );
  }
}
