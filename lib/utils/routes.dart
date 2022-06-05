import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/views/login_screen.dart';
import 'package:lead_management_system/src/auth/views/signup_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: LogInScreen.routeName,
    page: () => LogInScreen(),
  ),
  GetPage(
    name: SignUpScreen.routeName,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: DashboardScreen.routeName,
    page: () => const DashboardScreen(),
  ),
];
