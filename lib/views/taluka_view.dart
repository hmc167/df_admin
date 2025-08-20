import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/taluka_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class TalukaView extends StatefulWidget {
  const TalukaView({super.key});

  @override
  State<TalukaView> createState() => _TalukaViewState();
}

class _TalukaViewState extends State<TalukaView> {
  final TalukaController controller = Get.put(TalukaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('TalukaView Screen')),
    );
  }
}
