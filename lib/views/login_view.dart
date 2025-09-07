import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../utils/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(child: FlutterLogo(size: 200)),
              SizedBox(height: 20),
              TextField(
                focusNode: controller.usernameFocusNode,
                controller: controller.usernameController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  counterText: '', // hides the counter
                ),
                inputFormatters: [
                  // Only allow digits and limit to 10
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onSubmitted: (value) {
                  if (controller.usernameController.text.isEmpty) {
                    FocusScope.of(
                      context,
                    ).requestFocus(controller.usernameFocusNode);
                  } else if (controller.usernameController.text.isNotEmpty) {
                    FocusScope.of(
                      context,
                    ).requestFocus(controller.passwordFocusNode);
                  }
                },
              ),
              SizedBox(height: 10),
              Obx(
                () => TextField(
                  focusNode: controller.passwordFocusNode,
                  controller: controller.passwordController,
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  onSubmitted: (value) {
                    if (controller.usernameController.text.isEmpty) {
                      FocusScope.of(
                        context,
                      ).requestFocus(controller.usernameFocusNode);
                    } else if (controller.usernameController.text.isNotEmpty &&
                        controller.passwordController.text.isNotEmpty) {
                      controller.login();
                    }
                  },
                ),
              ),
              SizedBox(height: 30),

              Obx(
                () => controller.isLoading.value
                    ? Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.textColorWhite,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.primaryColor,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          onPressed: controller.login,
                          icon: Icon(
                            Icons.login,
                            size: 24,
                            color: AppColors.textColorWhite,
                          ),
                          label: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textColorWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
              Obx(
                () => Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
