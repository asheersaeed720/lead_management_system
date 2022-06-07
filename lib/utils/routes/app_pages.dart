import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/views/login_screen.dart';
import 'package:lead_management_system/src/auth/views/signup_screen.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/utils/routes/premium_route.dart';
import 'package:lead_management_system/utils/routes/routes.dart';

final List<GetPage<dynamic>> appPages = [
  GetPage(
    name: Routes.login,
    page: () => LogInScreen(),
  ),
  GetPage(
    name: Routes.signUp,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: Routes.dashboard,
    page: () => const DashboardScreen(),
    middlewares: [
      PremiumGuard(),
    ],
  ),
];
