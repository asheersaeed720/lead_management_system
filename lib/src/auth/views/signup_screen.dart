import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/utils/constants.dart';
import 'package:lead_management_system/utils/input_decoration.dart';
import 'package:lead_management_system/utils/input_validation_mixin.dart';
import 'package:lead_management_system/widgets/custom_async_btn.dart';

class SignUpScreen extends StatelessWidget with InputValidationMixin {
  static const String routeName = '/sign-up';

  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _moibleNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) => Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        "Registration",
                        style: kTitleStyle.copyWith(fontSize: 26.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) => validateName(value ?? ''),
                    decoration: buildTextFieldInputDecoration(
                      context,
                      labelTxt: 'Name',
                      preffixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _companyNameController,
                    validator: (value) => validateName(value ?? ''),
                    decoration: buildTextFieldInputDecoration(
                      context,
                      labelTxt: 'Company Name',
                    ),
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
                  IntlPhoneField(
                    controller: _moibleNoController,
                    decoration: buildTextFieldInputDecoration(
                      context,
                      labelTxt: 'Mobile No',
                      preffixIcon: const Icon(Icons.phone),
                    ),
                    initialCountryCode: 'PK',
                    keyboardType: TextInputType.phone,
                    pickerDialogStyle: PickerDialogStyle(width: _size.width * 0.5),
                    onChanged: (phone) {
                      log(phone.completeNumber);
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Address',
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) => validateName(value ?? ''),
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 3,
                    decoration: buildTextFieldInputDecoration(
                      context,
                      labelTxt: '',
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
                    height: 15,
                  ),
                  CustomAsyncBtn(
                    btnTxt: 'Sign Up',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        final isAuth = await authController.handleSignUp(
                          name: _nameController.text,
                          cname: _companyNameController.text,
                          email: _emailController.text,
                          mobileNo: _moibleNoController.text,
                          address: _addressController.text,
                          password: _passwordController.text,
                        );

                        if (isAuth) {
                          Get.offAndToNamed(DashboardScreen.routeName);
                        }
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
