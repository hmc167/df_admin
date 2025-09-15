import 'package:admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/unlock_request.dart';
import '../services/api_service_order.dart';
import '../utils/colors.dart';
import '../widgets/common_button.dart';

class DailyOrdersController extends GetxController {
  final RxnInt filterStatus = RxnInt(0);
  RxList<UnLockRequest> unLockRequests = <UnLockRequest>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final totalRecords = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    getUnLockRequests();
  }

  Future<void> getUnLockRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      var model = await ApiServiceOrder.allUnLockRequests(
        status: filterStatus.value,
      );
      unLockRequests.value = model.data?.records ?? [];
      totalRecords.value = model.data?.totalRecords ?? 0;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetSearchFilters() async {
    filterStatus.value = 0;
    await getUnLockRequests();
  }

  Future<void> search() async {
    await getUnLockRequests();
  }

  void deleteUnlockRequest(UnLockRequest unlockRequest) {
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
          final result = await ApiServiceOrder.changeStatusUnLockRequests(
            unlockRequest.id ?? 0,
            ChangeStatusAction.delete,
          );
          if ((result.data ?? false) == true) {
            Get.back();
            Get.snackbar(
              'Success',
              'Unlock request deleted successfully',
              backgroundColor: Colors.greenAccent,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
            );
            await getUnLockRequests();
          } else {
            Get.back();
            Get.snackbar(
              'Error',
              result.message?.message ?? 'Something went wrong',
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
            );
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
          'Are you sure you want to delete this?\nThis action cannot be reversed.\n',
    );
  }

  void editUnlockRequest(UnLockRequest unlockRequest) {
    TextEditingController notesController = TextEditingController();
notesController.text = unlockRequest.remarks ?? '';
    Get.defaultDialog(
      backgroundColor: AppColors.textColorWhite,
      titleStyle: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 8,
      title: 'Confirm Unlock',
      content: Column(
        children: [
          Text(
            'Are you sure you want to Unlock this Order?\nThis action cannot be reversed.\n',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textColor, fontSize: 18),
          ),
          SizedBox(height: 10),
          TextField(
            controller: notesController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Notes",
              hintText: "Enter your remarks here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      confirm: CommonButton(
        width: 100,
        text: "Unlock",
        onTap: () async {
          final result = await ApiServiceOrder.changeStatusUnLockRequests(
            unlockRequest.id ?? 0,
            ChangeStatusAction.changeStatus,
            notes: notesController.text,
            customerId: unlockRequest.customerId,
            orderId: unlockRequest.orderId,
          );
          if ((result.data ?? false) == true) {
            Get.back();
            Get.snackbar(
              'Success',
              'Unlock request unlocked successfully',
              backgroundColor: Colors.greenAccent,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
            );
            await getUnLockRequests();
          } else {
            Get.back();
            Get.snackbar(
              'Error',
              result.message?.message ?? 'Something went wrong',
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(10),
            );
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
    );
  }
}
