import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/usermodules_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class UserModulesView extends StatefulWidget {
  const UserModulesView({super.key});

  @override
  State<UserModulesView> createState() => _UserModulesViewState();
}

class _UserModulesViewState extends State<UserModulesView> {
  final UserModulesController controller = Get.put(UserModulesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('UserModulesView Screen')),
    );
  }
}
