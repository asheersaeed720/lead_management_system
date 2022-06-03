import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_controller.dart';
import 'package:lead_management_system/src/auth/auth_service.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';
import 'package:lead_management_system/src/network_manager.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(DashboardController(), permanent: true);
  }
}
