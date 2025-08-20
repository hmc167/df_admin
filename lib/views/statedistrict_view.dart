import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/statedistrict_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class StateDistrictView extends StatefulWidget {
  const StateDistrictView({super.key});

  @override
  State<StateDistrictView> createState() => _StateDistrictViewState();
}

class _StateDistrictViewState extends State<StateDistrictView> {
  final StateDistrictController controller = Get.put(StateDistrictController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('StateDistrictView Screen')),
    );
  }
}
