import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/changepassword_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ChangePassword Screen')),
    );
  }
}
