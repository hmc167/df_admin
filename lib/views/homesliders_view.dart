import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/homesliders_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class HomeSlidersView extends StatefulWidget {
  const HomeSlidersView({super.key});

  @override
  State<HomeSlidersView> createState() => _HomeSlidersViewState();
}

class _HomeSlidersViewState extends State<HomeSlidersView> {
  final HomeSlidersController controller = Get.put(HomeSlidersController());
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
