import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/taxmaster_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class TaxMasterView extends StatefulWidget {
  const TaxMasterView({super.key});

  @override
  State<TaxMasterView> createState() => _TaxMasterViewState();
}

class _TaxMasterViewState extends State<TaxMasterView> {
  final TaxMasterController controller = Get.put(TaxMasterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('TaxMasterView Screen')),
    );
  }
}
