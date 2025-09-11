import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_suggests.dart';
import '../services/api_service_product_master.dart';
import '../utils/constants.dart';

class SuggestsProductController extends GetxController {
  final filterStatus = 0.obs;
  RxList<ProductSuggest> suggests = <ProductSuggest>[].obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getSuggests();
    // Future.delayed(Duration(milliseconds: 300), () {
    //   //nameFocusNode.requestFocus();
    // });
  }

  Future<void> changeStatusSuggest(ProductSuggest suggest, int status) async {
    errorMessage.value = '';
    var sts = await onStatusChange(suggest.id!, status);
    if (sts) {
      await getSuggests();
    }
  }

  Future<void> getSuggests() async {
    int sts = filterStatus.value;
    final result = await ApiServiceProductMaster.allSuggests(status: sts);
    if (result.hasError == false) {
      var dbRecords = result.data?.records ?? [];
      if (dbRecords.isNotEmpty) {
        suggests.value = dbRecords;
      }
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'No record found';
    }
  }

  Future<bool> onStatusChange(int id, int status) async {
    final result = await ApiServiceProductMaster.changeStatusSuggests(
      id,
      ChangeStatusAction.changeStatus,
      status,
    );
    if (result.data == true) {
      Get.snackbar(
        'Success',
        'Status changed successfully',
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      await getSuggests();
      return true;
    }
    return false;
  }

  Future<void> resetSearchFilters() async {
    filterStatus.value = -1;
    await searchSuggests();
  }

  Future<void> searchSuggests() async {
    await getSuggests();
    int sts = filterStatus.value;

    List<ProductSuggest> filtered = suggests.where((suggest) {
      final matchesStatus = sts == -1 || (suggest.status == sts);
      return matchesStatus;
    }).toList();
    suggests.value = filtered;
  }
}
