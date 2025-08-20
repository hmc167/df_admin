import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/utils/colors.dart';

import '../controllers/advertisements_controller.dart';
import '../widgets/appbar.dart';

class AdvertisementsView extends StatefulWidget {
  const AdvertisementsView({super.key});

  @override
  State<AdvertisementsView> createState() => _AdvertisementsViewState();
}

class _AdvertisementsViewState extends State<AdvertisementsView> {
  final AdvertisementsController controller = Get.put(
    AdvertisementsController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('Advertisements Screen')),
    );
  }
}
