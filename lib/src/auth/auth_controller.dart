import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/src/auth/auth_service.dart';
import 'package:lead_management_system/src/network_manager.dart';
import 'package:lead_management_system/utils/custom_snack_bar.dart';
import 'package:lead_management_system/utils/display_toast_message.dart';

class AuthController extends NetworkManager {
  final _authService = Get.find<AuthService>();

  User? currentUserData;

  bool isLoading = false;

  bool isRemember = false;

  bool obscureText = true;

  String rememberEmail = '';

  @override
  void onInit() {
    log('${FirebaseAuth.instance.currentUser}', name: 'Firebase User');
    currentUserData = getCurrentUser();
    // rememberEmail = _getStorage.read('email') ?? '';
    super.onInit();
  }

  void togglePw() {
    obscureText = !obscureText;
    update();
  }

  Future<bool> handleSignUp({
    required String name,
    required String cname,
    required String email,
    required String mobileNo,
    required String address,
    required String password,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.signUpUser(name, cname, email, mobileNo, address, password)) !=
          null);
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  Future<bool> handleLogIn({
    required String email,
    required String password,
  }) async {
    if (connectionType != 0) {
      bool isAuth = ((await _authService.logInUser(email, password)) != null);
      if (isAuth) {
        currentUserData = getCurrentUser();
      }
      return isAuth;
    } else {
      // customSnackBar('Network error', 'Please try again later');
      displayToastMessage('Network Error');
      return false;
    }
  }

  Future<bool> handleUpdatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.updatePassword(currentPassword, newPassword)) != null);
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  User? getCurrentUser() {
    // User? userData = _getStorage.read('user');
    // User? user = userData;
    // log('$userData', name: 'storeUser');
    // return user;
    User? user;
    return user;
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    // _getStorage.remove('user');
    // currentUserData = _getStorage.read('user');
    // update();
    displayToastMessage('Logout');
    // Get.offAllNamed(Routes.login);
  }
}
