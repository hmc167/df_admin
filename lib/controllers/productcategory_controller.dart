import 'package:admin/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/product_category.dart';
import '../utils/helpers.dart';
import '../widgets/common_button.dart';

class ProductCategoryController extends GetxController {
  final filterNameController = TextEditingController();
  final filterParentCategoryId = 0.obs;
  final filterStatus = 0.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sortOrderController = TextEditingController();
  final status = false.obs;
  final parentCategoryId = 0.obs;

  final nameFocusNode = FocusNode();
  final parentCategoryFocusNode = FocusNode();
  final sortOrderFocusNode = FocusNode();
  final statusFocusNode = FocusNode();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  List<ProductCategory> get parentCategories => getParentCategories();

  RxList<ProductCategory> categories = <ProductCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    categories.value = getCategories();
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  List<ProductCategory> getParentCategories() {
    return [
      ProductCategory(
        iD: 0,
        name: 'No Parent Category',
        parentCategoryID: null,
        status: true,
      ),
      ProductCategory(
        iD: 1,
        name: 'Daily Fresh',
        parentCategoryID: null,
        status: true,
      ),
      ProductCategory(
        iD: 5,
        name: 'Seasonal Store',
        parentCategoryID: null,
        status: true,
      ),
    ];
  }

  void toggleStatus() {
    status.value = !status.value;
  }

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    sortOrderController.clear();
    status.value = false;
    parentCategoryId.value = 0;
    nameFocusNode.requestFocus();
  }

  Future<void> openAddCategoryPopup(ProductCategory category) async {
    int categoryId = category.iD ?? 0;
    nameController.text = category.name ?? '';
    descriptionController.text = category.description ?? '';
    sortOrderController.text = category.sortOrder?.toString() ?? '';
    status.value = category.status ?? false;
    parentCategoryId.value = category.parentCategoryID ?? 0;

    await Helpers.showPopup(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              categoryId > 0 ? 'Edit Category' : 'Add New Category',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: TextFormField(
                          focusNode: nameFocusNode,
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Obx(
                            () => DropdownButton<int>(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              value: parentCategoryId.value,
                              isExpanded: true,
                              borderRadius: BorderRadius.zero,
                              underline: const DropdownButtonHideUnderline(
                                child: SizedBox.shrink(),
                              ),
                              items: parentCategories
                                  .map(
                                    (category) => DropdownMenuItem<int>(
                                      value: category.iD ?? 0,
                                      child: Text(category.name ?? ''),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                parentCategoryId.value = value ?? 0;
                              },
                              hint: Text('Select Parent Category'),
                              dropdownColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,

                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: sortOrderController,
                          decoration: InputDecoration(
                            hintText: 'Sort Order',
                            labelText: 'Sort Order',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          keyboardType: TextInputType.number,
                          focusNode: sortOrderFocusNode,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Obx(
                              () => CupertinoSwitch(
                                value: status.value,
                                onChanged: (value) {
                                  status.value = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 0),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  text: "Close",
                  color: AppColors.textColorWhite,
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 20),
                CommonButton(
                  text: "Save",
                  onTap: () {
                    saveCategory(categoryId);
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
      height: 500,
      width: 650,
    );
  }

  void saveCategory(int categoryId) {
    if (nameController.text.isEmpty) {
      errorMessage.value = 'Name cannot be empty';
      return;
    }

    if (sortOrderController.text.isEmpty) {
      errorMessage.value = 'Sort Order cannot be empty';
      return;
    }

    final newCategory = ProductCategory(
      iD: categoryId,
      name: nameController.text,
      description: descriptionController.text,
      parentCategoryID: parentCategoryId.value,
      sortOrder: int.tryParse(sortOrderController.text) ?? 0,
      status: status.value,
    );

    print('Saving category: ${newCategory.toJson()}');
    clearFields();
    Get.back();
    Get.snackbar(
      'Success',
      'Category saved successfully',
      backgroundColor: Colors.greenAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
    );
  }

  void deleteCategory(ProductCategory category) {
    if (category.iD != null) {
      Get.defaultDialog(
        backgroundColor: AppColors.textColorWhite,
        titleStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        titlePadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        radius: 4,
        confirm: CommonButton(
          width: 100,
          text: "Delete",
          onTap: () {
            Get.back();

            Get.snackbar(
              'Success',
              'Category deleted successfully',
              backgroundColor: Colors.greenAccent,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
            );
          },
        ),
        cancel: CommonButton(
          width: 100,
          text: "Cancel",
          color: AppColors.textColorWhite,
          textColor: AppColors.primaryColor,
          onTap: () {
            Get.back();
          },
        ),
        title: 'Confirm Delete',
        middleText:
            'Are you sure you want to delete this category (${category.name})?\nThis action cannot be reversed.\n',
      );
    } else {
      Get.snackbar(
        'Delete Error',
        'Cannot delete a category without an ID',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  List<ProductCategory> getCategories() {
    return [
      ProductCategory(
        iD: 1,
        name: 'Daily Fresh',
        parentCategoryID: null,
        status: true,
        description: 'Fresh produce delivered daily',
        sortOrder: 1,
      ),
      ProductCategory(
        iD: 2,
        name: 'Vegetables',
        parentCategoryID: 1,
        status: true,
        description: 'Fresh and organic vegetables',
        sortOrder: 1,
      ),
      ProductCategory(
        iD: 3,
        name: 'Fruits',
        parentCategoryID: 1,
        status: true,
        description: 'Seasonal and exotic fruits',
        sortOrder: 2,
      ),
      ProductCategory(
        iD: 4,
        name: 'Pooja Needs',
        parentCategoryID: 1,
        status: false,
        description: 'All your pooja essentials',
        sortOrder: 3,
      ),
      ProductCategory(
        iD: 5,
        name: 'Seasonal Store',
        parentCategoryID: null,
        status: true,
        description: 'Special items for the season',
        sortOrder: 2,
      ),
    ];
  }

  void resetSearchFilters() {
    filterNameController.clear();
    filterParentCategoryId.value = 0;
    filterStatus.value = 0;
    searchCategories();
  }

  void searchCategories() {
    String text = filterNameController.text;
    int value = filterParentCategoryId.value;
    int value2 = filterStatus.value;

    // Implement search logic here
    // Example: Filter categories based on name, parentCategoryId, and status
    List<ProductCategory> filtered = getCategories().where((category) {
      final matchesName =
          text.isEmpty ||
          (category.name?.toLowerCase().contains(text.toLowerCase()) ?? false);
      final matchesParent = value == 0 || category.parentCategoryID == value;
      final matchesStatus =
          value2 == 0 ||
          (value2 == 1 ? category.status == true : category.status == false);
      return matchesName && matchesParent && matchesStatus;
    }).toList();
    categories.value = filtered;
  }
}
