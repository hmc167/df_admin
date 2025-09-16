import 'package:admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../widgets/common_button.dart';

class Helpers {
  static Future<T?> showPopup<T>(
    Widget item, {
    double? width,
    double? height,
    bool allowClose = true,
  }) {
    width ??= Get.width * 0.98;
    height ??= Get.height * 0.85;

    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      content: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Colors.white),
        child: item,
      ),
    );

    return showDialog(
      barrierDismissible: allowClose,
      context: Get.context!,
      useSafeArea: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
  }) async {
    return await Get.defaultDialog(
          title: title,
          middleText: message,
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
            text: confirmText,
            onTap: () async {
              {
                Get.back(result: true);
              }
            },
          ),
          cancel: CommonButton(
            width: 100,
            text: cancelText,
            color: AppColors.textColorWhite,
            textColor: AppColors.primaryColor,
            onTap: () {
              Get.back(result: false);
            },
          ),
        ) ??
        false;
  }
}
