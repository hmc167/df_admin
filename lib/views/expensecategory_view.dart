import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expensecategory_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class ExpenseCategoryView extends StatefulWidget {
  const ExpenseCategoryView({super.key});

  @override
  State<ExpenseCategoryView> createState() => _ExpenseCategoryViewState();
}

class _ExpenseCategoryViewState extends State<ExpenseCategoryView> {
  final ExpenseCategoryController controller = Get.put(
    ExpenseCategoryController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('ExpenseCategory Screen')),
    );
  }
}
