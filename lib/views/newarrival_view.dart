import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/newarrival_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class NewArrivalView extends StatefulWidget {
  const NewArrivalView({super.key});

  @override
  State<NewArrivalView> createState() => _NewArrivalViewState();
}

class _NewArrivalViewState extends State<NewArrivalView> {
  final NewArrivalController controller = Get.put(NewArrivalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('NewArrivalView Screen')),
    );
  }
}
