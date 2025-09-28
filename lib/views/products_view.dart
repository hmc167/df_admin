import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/products_controller.dart';
import '../models/product_master.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsController controller = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is Map && args['status'] != null) {
      controller.filterStatus.value = args['status'] as int;
      controller.searchProducts();
    } else if (args != null && args is Map && args['search'] != null) {
      controller.filterNameController.text = args['search'] as String;
      controller.searchProducts();
    } else {
      controller.loadData();
    }
  }

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
              'Products',
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
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterCategoryId.value,
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text('All Categories'),
                        ),
                        ...controller.productCategories
                            .where((x) => x.iD != 0)
                            .map(
                              (category) => DropdownMenuItem<int>(
                                value: category.iD ?? 0,
                                child: Text(category.name ?? ''),
                              ),
                            ),
                      ],
                      onChanged: (value) {
                        controller.filterCategoryId.value = value ?? 0;
                      },
                      hint: Text('Select Category'),
                      dropdownColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.filterNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
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
                      controller.searchProducts();
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
                      await controller.openAddProductPopup(ProductMaster());
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
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Category',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Unit(Variant) Category',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    width: 150,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
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
                    ...List.generate(controller.products.length, (index) {
                      var product = controller.products[index];
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
                                  product.name ?? '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              child: Text(
                                product.categoryName ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                product.unitName ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                product.sortOrder?.toString() ?? '0',
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
                                    child: product.isActive == true
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
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await controller
                                          .openManageProductVariantPopup(
                                            product,
                                          );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.event_available_outlined,
                                        size: 20,
                                        color: AppColors.warningColor,
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      await controller.openAddProductPopup(
                                        product,
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
                                      controller.deleteProduct(product);
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
                    if (controller.products.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textColorWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'No records found',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
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
                      'Total Categories: ${controller.products.length}',
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
