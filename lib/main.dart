import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lead_management_system/src/auth/views/login_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/src/main_binding.dart';
import 'package:lead_management_system/utils/routes.dart';

import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    // name: "Lead-Management-System",
    options: const FirebaseOptions(
      apiKey: "AIzaSyA_g8DuqmiEqEgJ24T5Gm85VCYcJskW7mE",
      appId: "1:961478406417:web:e97f7f7620a16e5ee29cb0",
      messagingSenderId: "961478406417",
      projectId: "lead-management-system-fdd3d",
    ),
  );
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
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LogInScreen.routeName
            : DashboardScreen.routeName,
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
