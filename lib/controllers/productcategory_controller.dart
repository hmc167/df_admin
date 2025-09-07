import 'package:admin/utils/colors.dart';
import 'package:admin/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../models/category_master.dart';
import '../services/api_service_category_master.dart';
import '../utils/helpers.dart';
import '../widgets/common_button.dart';

class ProductCategoryController extends GetxController {  
  final pickedImageFile = Rx<File?>(null);
  final filterNameController = TextEditingController();
  final filterParentCategoryId = 0.obs;
  final filterStatus = 0.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sortOrderController = TextEditingController();
  final status = false.obs;
  final parentCategoryId = 0.obs;
  final image = "".obs;

  final nameFocusNode = FocusNode();
  final parentCategoryFocusNode = FocusNode();
  final sortOrderFocusNode = FocusNode();
  final statusFocusNode = FocusNode();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  RxList<CategoryMaster> categories = <CategoryMaster>[].obs;
  RxList<CategoryMaster> parentCategories = <CategoryMaster>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
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
  image.value = "";
  pickedImageFile.value = null;
  }

  Future<void> openAddCategoryPopup(CategoryMaster category) async {
  int categoryId = category.iD ?? 0;
  nameController.text = category.name ?? '';
  descriptionController.text = category.desc ?? '';
  sortOrderController.text = category.sortOrder?.toString() ?? '';
  status.value = category.isActive ?? false;
  parentCategoryId.value = category.parentCategoryMasterId ?? 0;
  image.value = category.image ?? '';
  print(category.image ?? '');
  pickedImageFile.value = null;
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                      ),
                      SizedBox(width: 10,),
                      Obx(() {
                        final imgFile = pickedImageFile.value;
                        final imgUrl = image.value;
                        return Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: imgFile != null
                                  ? Image.file(imgFile, fit: BoxFit.cover)
                                  : (imgUrl.isNotEmpty
                                      ? Image.network(imgUrl, fit: BoxFit.cover)
                                      : Icon(Icons.image, size: 50, color: Colors.grey)),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton.icon(
                              icon: Icon(Icons.upload),
                              label: Text('Choose Image'),
                              onPressed: () async {
                                final picker = ImagePicker();
                                final picked = await picker.pickImage(source: ImageSource.gallery);
                                if (picked != null) {
                                  pickedImageFile.value = File(picked.path);
                                  final result = await ApiServiceCategoryMaster.uploadFile(File(picked.path));
                                  if(result.hasError == false) {
                                    image.value = result.data?.fileKey??'';
                                  } else {
                                    Get.snackbar(
                                      'Upload Error',
                                      result.errors?.firstOrNull?.message ?? 'Error uploading image',
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: EdgeInsets.all(10),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        );
                      }),
                    ],
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

  Future<void> saveCategory(int categoryId) async {
    if (nameController.text.isEmpty) {
      errorMessage.value = 'Name cannot be empty';
      return;
    }

    if (sortOrderController.text.isEmpty) {
      errorMessage.value = 'Sort Order cannot be empty';
      return;
    }

    //String? imagePath 
    // if (pickedImageFile.value != null) {
    //   imagePath = pickedImageFile.value!.path;
    // } else {
    //   imagePath = image.value;
    // }
    final newCategory = CategoryMaster(
      iD: categoryId,
      name: nameController.text,
      desc: descriptionController.text,
      parentCategoryMasterId: parentCategoryId.value,
      sortOrder: int.tryParse(sortOrderController.text) ?? 0,
      isActive: status.value,
      image: image.value,
    );

    final result = await ApiServiceCategoryMaster.save(newCategory);
    if (result.hasError == false) {
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
      await getCategories();
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'Error saving category';
      return;
    }
  }

  void deleteCategory(CategoryMaster category) {
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
          onTap: () async {
            final result = await ApiServiceCategoryMaster.changeStatus(
              category,
              ChangeStatusAction.delete,
            );
            if (result.data == true) {
              Get.back();
              Get.snackbar(
                'Success',
                'Category deleted successfully',
                backgroundColor: Colors.greenAccent,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(10),
              );
              await getCategories();
            }
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

  Future<void> getCategories() async {
    final result = await ApiServiceCategoryMaster.all();
    if (result.hasError == false) {
      var dbCategories = result.data?.records ?? [];
      if (dbCategories.isNotEmpty) {
        categories.value = dbCategories;
        var pCats = [
          CategoryMaster(
            iD: 0,
            name: 'No Parent Category',
            parentCategoryMasterId: null,
            isActive: true,
          ),
        ];
        pCats.addAll(
          dbCategories
              .where((c) => (c.parentCategoryMasterId ?? 0) == 0)
              .toList(),
        );
        parentCategories.value = pCats;
      }
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'No record found';
    }
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    filterParentCategoryId.value = 0;
    filterStatus.value = 0;
    await searchCategories();
  }

  Future<void> searchCategories() async {
    await getCategories();
    String text = filterNameController.text;
    int value = filterParentCategoryId.value;
    int value2 = filterStatus.value;

    List<CategoryMaster> filtered = categories.where((category) {
      final matchesName =
          text.isEmpty ||
          (category.name?.toLowerCase().contains(text.toLowerCase()) ?? false);
      final matchesParent =
          value == 0 || category.parentCategoryMasterId == value;
      final matchesStatus =
          value2 == 0 ||
          (value2 == 1
              ? category.isActive == true
              : category.isActive == false);
      return matchesName && matchesParent && matchesStatus;
    }).toList();
    categories.value = filtered;
  }
}
