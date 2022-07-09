import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lead_management_system/src/hive/hive_storage_service.dart';
import 'package:lead_management_system/src/main_binding.dart';
import 'package:lead_management_system/utils/routes/route_delegate.dart';
import 'package:lead_management_system/utils/routes/route_information_parser.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:url_strategy/url_strategy.dart';

import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openHiveBox('user');

  setPathUrlStrategy();
  bool isUserLoggedIn = await HiveDataStorageService.getUser();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA_g8DuqmiEqEgJ24T5Gm85VCYcJskW7mE",
        appId: "1:961478406417:web:e97f7f7620a16e5ee29cb0",
        messagingSenderId: "961478406417",
        projectId: "lead-management-system-fdd3d",
      ),
    );
  } else {
    await Firebase.initializeApp(
      name: "Lead-Management-System",
      options: const FirebaseOptions(
        apiKey: "AIzaSyA_g8DuqmiEqEgJ24T5Gm85VCYcJskW7mE",
        appId: "1:961478406417:web:e97f7f7620a16e5ee29cb0",
        messagingSenderId: "961478406417",
        projectId: "lead-management-system-fdd3d",
      ),
    );
  }

  runApp(MyApp(
    isLoggedIn: isUserLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Lead Management System',
      theme: lightThemeData,
      initialBinding: MainBinding(),
      routeInformationParser: RoutesInformationParser(),
      routerDelegate: AppRouterDelegate(isLoggedIn: isLoggedIn),
    );
  }
}

Future<Box> openHiveBox(String boxName) async {
  if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
    Hive.init((await path_provider.getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}
