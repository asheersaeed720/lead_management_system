import 'package:get/get.dart';
import 'package:lead_management_system/src/dashboard/dashboard_screen.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController(), permanent: true);
  }
}
