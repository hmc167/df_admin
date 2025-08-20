import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/unitvariant_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class UnitVariantView extends StatefulWidget {
  const UnitVariantView({super.key});

  @override
  State<UnitVariantView> createState() => _UnitVariantViewState();
}

class _UnitVariantViewState extends State<UnitVariantView> {
  final UnitVariantController controller = Get.put(UnitVariantController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('UnitVariantView Screen')),
    );
  }
}
