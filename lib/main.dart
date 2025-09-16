import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'controllers/login_controller.dart';
import 'routes/app_pages.dart';

final LoginController loginController = Get.put(LoginController());

void main() {
  runApp(MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    win.maximize();
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dhanfuliya Fresh Admin',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
