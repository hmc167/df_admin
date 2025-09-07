import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service_login.dart';
import '../routes/app_pages.dart';
import '../services/storage_service.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  final isLoading = false.obs;

  final errorMessage = ''.obs;
  final showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Set initial focus to username field
    usernameController.text = '1234567890';
    passwordController.text = 'Test@123';
    Future.delayed(Duration(milliseconds: 300), () {
      usernameFocusNode.requestFocus();
    });
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;
    if (username == '') {
      errorMessage.value = 'Mobile Number is required';
      return;
    } else if (password == '') {
      errorMessage.value = 'Password is required';
      return;
    }
    // else if (!RegExp(
    //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}$',
    // ).hasMatch(password)) {
    //   errorMessage.value = 'Invalid password format';
    //   return;
    // }
    isLoading.value = true;
    try {
        final result = await ApiServiceLogin.login(username, password);
        if (result.hasError == false) {
          var token = result.data?.tokenDetails?.token;
          if (token != null) {
            await StorageService.saveToken(token);
            Get.offAllNamed(Routes.DASHBOARD);
          }
        } else {
          errorMessage.value =
              result.errors?.firstOrNull?.message ?? 'Invalid username or password';
        }
    } catch (e) {
      if (kDebugMode) {
        print(e) ;
      }      
    }
    finally{
      isLoading.value = false;
    }
  }

  var selectedMenu = 'Dashboard'.obs;

  void selectMenu(String item) {
    selectedMenu.value = item;
  }

  void logout() async {
    await StorageService.clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
