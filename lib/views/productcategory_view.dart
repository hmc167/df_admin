import 'package:admin/models/category_master.dart';
import 'package:admin/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/productcategory_controller.dart';
import '../models/product_category.dart';
import '../utils/helpers.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class ProductCategoryView extends StatefulWidget {
  const ProductCategoryView({super.key});

  @override
  State<ProductCategoryView> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends State<ProductCategoryView> {
  final ProductCategoryController controller = Get.put(
    ProductCategoryController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.filterNameController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterStatus.value,
                      hint: Text('Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(value: 0, child: Text('All')),
                        DropdownMenuItem(value: 1, child: Text('Active')),
                        DropdownMenuItem(value: 2, child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        controller.filterStatus.value = value ?? 0;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  CommonButton(
                    width: 120,
                    text: 'Search',
                    icon: Icons.search,
                    onTap: () async {
                      controller.searchCategories();
                    },
                  ),
                  CommonButton(
                    width: 120,
                    text: 'Reset',
                    icon: Icons.refresh,
                    color: AppColors.backgroundColor,
                    textColor: AppColors.primaryColor,
                    onTap: () async {
                      // Reset search filters
                      controller.resetSearchFilters();
                    },
                  ),
                  Spacer(),
                  CommonButton(
                    text: 'Add New',
                    icon: Icons.add,
                    onTap: () async {
                      await controller.openAddCategoryPopup(CategoryMaster());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Parent Category',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      'Sort Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Obx(
                () => ListView(
                  children: [
                    ...List.generate(controller.categories.length, (index) {
                      var category = controller.categories[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColors.textColorWhite
                              : AppColors.borderColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 40, child: Text('${index + 1}')),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  category.name ?? '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  category.parentCategoryMasterId == null ||
                                          category.parentCategoryMasterId == 0
                                      ? '--'
                                      : controller.parentCategories
                                                .firstWhere(
                                                  (c) =>
                                                      c.iD ==
                                                      category.parentCategoryMasterId,
                                                )
                                                .name ??
                                            '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                category.sortOrder?.toString() ?? '0',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  //
                                },
                                child: SizedBox(
                                  width: 80,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: category.isActive == true
                                        ? Icon(
                                            Icons.check_circle,
                                            color: AppColors.successColor,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: AppColors.errorColor,
                                            size: 20,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await controller.openAddCategoryPopup(
                                        category,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: AppColors.infoColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.deleteCategory(category);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: AppColors.errorColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      'Total Categories: ${controller.categories.length}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.arrow_upward, color: AppColors.primaryColor),
                  //     SizedBox(width: 20),
                  //     Icon(Icons.arrow_downward, color: AppColors.primaryColor),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
