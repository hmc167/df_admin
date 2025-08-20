import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expenses_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final ExpensesController controller = Get.put(ExpensesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('Expenses Screen')),
    );
  }
}
