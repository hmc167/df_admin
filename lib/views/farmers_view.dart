import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/farmers_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class FarmersView extends StatefulWidget {
  const FarmersView({super.key});

  @override
  State<FarmersView> createState() => _FarmersViewState();
}

class _FarmersViewState extends State<FarmersView> {
  final FarmersController controller = Get.put(FarmersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('FarmersView Screen')),
    );
  }
}
