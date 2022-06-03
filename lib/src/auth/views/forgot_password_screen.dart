import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/widgets/custom_async_btn.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-pw';

  ForgotPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/get_started_bg.jpg'),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: GetBuilder<AuthController>(
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ic_launcher.png', width: 130.0),
                  const SizedBox(height: 18.0),
                  Text(
                    'Reset Password',
                    // style: kTitleStyle,
                  ),
                  const Text(
                    'This action will send password at your email.',
                  ),
                  const SizedBox(height: 18.0),
                  // const CustomTextField(
                  //   prefixIcon: Icons.email,
                  //   hintText: 'Email',
                  //   isEmail: true,
                  // ),
                  const SizedBox(height: 18.0),
                  CustomAsyncBtn(
                    btntxt: 'SEND CODE',
                    onPress: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
