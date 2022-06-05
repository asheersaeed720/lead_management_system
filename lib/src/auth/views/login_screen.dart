import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/src/auth/views/signup_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/input_decoration.dart';
import 'package:lead_management_system/utils/input_validation_mixin.dart';
import 'package:lead_management_system/widgets/custom_async_btn.dart';

class LogInScreen extends StatelessWidget with InputValidationMixin {
  static const String routeName = '/login';

  LogInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) => Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/logo.png", width: 200.0),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "Log In",
                        style: kTitleStyle.copyWith(fontSize: 26.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text("Welcome back to the admin panel."),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) => validateEmail(value ?? ''),
                    decoration: buildTextFieldInputDecoration(
                      context,
                      labelTxt: 'Email',
                      preffixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: authController.obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => validatePassword(value ?? ''),
                    decoration: buildPasswordInputDecoration(
                      context,
                      labelTxt: 'Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          authController.obscureText = !authController.obscureText;
                          authController.update();
                        },
                        child: Icon(
                          authController.obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: authController.isRemember,
                            onChanged: (_) {
                              authController.isRemember = !authController.isRemember;
                              authController.update();
                            },
                          ),
                          InkWell(
                            onTap: () {
                              authController.isRemember = !authController.isRemember;
                              authController.update();
                            },
                            child: const Text("Remeber Me"),
                          ),
                        ],
                      ),
                      Text("Forgot password?", style: kBodyStyle)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAsyncBtn(
                    btnTxt: 'Log In',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        final isAuth = await authController.handleLogIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (isAuth) {
                          Get.offNamed(DashboardScreen.routeName);
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Free trial for 30 days"),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(SignUpScreen.routeName);
                        },
                        child: Text(
                          "Register Now!",
                          style: kBodyStyle.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
