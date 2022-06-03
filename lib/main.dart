import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/views/auth_screen.dart';
import 'package:lead_management_system/src/main_binding.dart';
import 'package:lead_management_system/utils/routes.dart';

import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lead Management System',
        theme: lightThemeData,
        initialBinding: MainBinding(),
        initialRoute: AuthScreen.routeName,
        getPages: routes,
        scrollBehavior: CustomScrollBehaviour(),
      );
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
