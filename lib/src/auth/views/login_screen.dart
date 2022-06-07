import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/input_decoration.dart';
import 'package:lead_management_system/utils/input_validation_mixin.dart';
import 'package:lead_management_system/utils/routes/routes.dart';
import 'package:lead_management_system/widgets/custom_async_btn.dart';

class LogInScreen extends StatelessWidget with InputValidationMixin {
  LogInScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  doLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      _authController.isLoading = true;
      final isAuth = await _authController.handleLogIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _authController.isLoading = false;
      if (isAuth) {
        Get.offAndToNamed(Routes.dashboard);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (_) => Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24.0),
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
                    obscureText: _authController.obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => validatePassword(value ?? ''),
                    onFieldSubmitted: (_) async {
                      await doLogin(context);
                    },
                    decoration: buildPasswordInputDecoration(
                      context,
                      labelTxt: 'Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          _authController.obscureText = !_authController.obscureText;
                          _authController.update();
                        },
                        child: Icon(
                          _authController.obscureText ? Icons.visibility : Icons.visibility_off,
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
                            value: _authController.isRemember,
                            onChanged: (_) {
                              _authController.isRemember = !_authController.isRemember;
                              _authController.update();
                            },
                          ),
                          InkWell(
                            onTap: () {
                              _authController.isRemember = !_authController.isRemember;
                              _authController.update();
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
                    isLoading: _authController.isLoading,
                    onPress: () async {
                      await doLogin(context);
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
                          Get.toNamed(Routes.signUp);
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
