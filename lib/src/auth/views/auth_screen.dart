import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/input_decoration.dart';
import 'package:lead_management_system/utils/input_validation_mixin.dart';
import 'package:lead_management_system/widgets/custom_async_btn.dart';

class AuthScreen extends StatelessWidget with InputValidationMixin {
  static const String routeName = '/auth';

  AuthScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Row(
                    children: [
                      Image.asset("assets/icons/logo.png"),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Log In",
                        style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
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
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Required';
                    //   }
                    //   bool emailValid = RegExp(
                    //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(value);
                    //   return !emailValid ? "Enter valid email" : null;
                    // },
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
                    obscureText: true,
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
                    height: 15,
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
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        Get.offAndToNamed(DashboardScreen.routeName);
                      }
                    },
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
