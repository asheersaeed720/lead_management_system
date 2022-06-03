import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/views/auth_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: AuthScreen.routeName,
    page: () => const AuthScreen(),
  ),
  GetPage(
    name: DashboardScreen.routeName,
    page: () => const DashboardScreen(),
  ),
];
