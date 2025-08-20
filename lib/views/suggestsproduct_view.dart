import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/suggestsproduct_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class SuggestsProductView extends StatefulWidget {
  const SuggestsProductView({super.key});

  @override
  State<SuggestsProductView> createState() => _SuggestsProductViewState();
}

class _SuggestsProductViewState extends State<SuggestsProductView> {
  final SuggestsProductController controller = Get.put(
    SuggestsProductController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('SuggestsProductView Screen')),
    );
  }
}
