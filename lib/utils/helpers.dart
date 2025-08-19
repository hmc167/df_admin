import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
}
