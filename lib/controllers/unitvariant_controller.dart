import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/unitvariant_master.dart';
import '../services/api_service_unitvariant.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../utils/colors.dart';
import '../widgets/common_button.dart';

class UnitVariantController extends GetxController {
  final filterNameController = TextEditingController();
  final filterNameCategoryController = TextEditingController();

  final nameController = TextEditingController();
  final sortOrderController = TextEditingController();
  

  final nameFocusNode = FocusNode();
  final sortOrderFocusNode = FocusNode();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  RxList<UnitVariant> unitVariants = <UnitVariant>[].obs;
  RxList<UnitCategory> unitCategories = <UnitCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUnitVariants();
    getUnitCategories();
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  void clearFields() {
    nameController.clear();
    sortOrderController.clear();
    nameFocusNode.requestFocus();
  }

  Future<void> openAddUnitVariantPopup([UnitVariant? unitVariant]) async {
    int unitVariantId = unitVariant?.iD ?? 0;
    nameController.text = unitVariant?.name ?? '';
    sortOrderController.text = unitVariant?.sortOrder?.toString() ?? '';

    await Helpers.showPopup(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              unitVariantId > 0 ? 'Edit Unit Variant' : 'Add New Unit Variant',
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
                    children: [
                      Expanded(
                        child: TextFormField(
                          focusNode: nameFocusNode,
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: sortOrderController,
                          focusNode: sortOrderFocusNode,
                          decoration: InputDecoration(labelText: 'Sort Order'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  
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
                    saveUnitVariant(unitVariantId);
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

  Future<void> saveUnitVariant(int unitVariantId) async {
    if (nameController.text.isEmpty) {
      errorMessage.value = 'Name cannot be empty';
      return;
    }
    if (sortOrderController.text.isEmpty) {
      errorMessage.value = 'Sort Order cannot be empty';
      return;
    }

    final newUnitVariant = UnitVariant(
      iD: unitVariantId,
      name: nameController.text,
      sortOrder: int.tryParse(sortOrderController.text) ?? 0,
    );

    final result = await ApiServiceUnitVariantMaster.save(newUnitVariant);
    if (result.hasError == false) {
      clearFields();
      Get.back();
      Get.snackbar(
        'Success',
        'Unit Variant saved successfully',
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      await getUnitVariants();
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'Error saving unit variant';
      return;
    }
  }

  void deleteUnitVariant(UnitVariant unitVariant) {
    if (unitVariant.iD != null) {
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
            final result = await ApiServiceUnitVariantMaster.changeStatus(
              unitVariant,
              ChangeStatusAction.delete,
            );
            if (result.data == true) {
              Get.back();
              Get.snackbar(
                'Success',
                'Unit Variant deleted successfully',
                backgroundColor: Colors.greenAccent,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(10),
              );
              await getUnitVariants();
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
            'Are you sure you want to delete this unit variant (${unitVariant.name})?\nThis action cannot be reversed.\n',
      );
    } else {
      Get.snackbar(
        'Delete Error',
        'Cannot delete a unit variant without an ID',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getUnitVariants() async {
    isLoading.value = true;
    final result = await ApiServiceUnitVariantMaster.all();
    isLoading.value = false;
    if (result.hasError == false) {
      var dbUnitVariants = result.data?.records ?? [];
      unitVariants.value = dbUnitVariants;
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'No record found';
    }
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    await searchUnitVariants();
  }

  Future<void> searchUnitVariants() async {
    await getUnitVariants();
    String text = filterNameController.text;

    List<UnitVariant> filtered = unitVariants.where((unitVariant) {
      final matchesName =
          text.isEmpty ||
          (unitVariant.name?.toLowerCase().contains(text.toLowerCase()) ?? false);
      return matchesName;
    }).toList();
    unitVariants.value = filtered;
  }

  
  Future<void> getUnitCategories() async {
    isLoading.value = true;
    final result = await ApiServiceUnitVariantMaster.allCategory();
    isLoading.value = false;
    if (result.hasError == false) {
      var dbUnitCategories = result.data?.records ?? [];
      unitCategories.value = dbUnitCategories;
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'No categories found';
    }
  }

  Future<void> resetSearchFiltersCategory() async {
    filterNameCategoryController.clear();
    await getUnitCategories();
  }

  Future<void> searchUnitCategory() async {
    await getUnitCategories();
    String text = filterNameCategoryController.text;

    List<UnitCategory> filtered = unitCategories.where((unitCategory) {
      final matchesName =
          text.isEmpty ||
          (unitCategory.name?.toLowerCase().contains(text.toLowerCase()) ?? false);
      return matchesName;
    }).toList();
    unitCategories.value = filtered;
  }
}
