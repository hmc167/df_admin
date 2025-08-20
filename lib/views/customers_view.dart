import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  final CustomersController controller = Get.put(CustomersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('Customers Screen')),
    );
  }
}
