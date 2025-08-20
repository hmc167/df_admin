import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/farmersaccount_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class FarmersAccountView extends StatefulWidget {
  const FarmersAccountView({super.key});

  @override
  State<FarmersAccountView> createState() => _FarmersAccountViewState();
}

class _FarmersAccountViewState extends State<FarmersAccountView> {
  final FarmersAccountController controller = Get.put(
    FarmersAccountController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('FarmersAccount Screen')),
    );
  }
}
