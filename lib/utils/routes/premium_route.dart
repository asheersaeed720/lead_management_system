import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_management_system/utils/routes/fake_auth.dart';

class PremiumGuard extends GetMiddleware {
  final _fakeAuth = Get.find<FakeAuthService>();

  @override
  int? get priority => 2;

  bool isAuthenticated = FirebaseAuth.instance.currentUser == null ? false : true;

  // @override
  // RouteSettings? redirect(String? route) {
  //   log('isAuthenticated $isAuthenticated');
  //   if (isAuthenticated) {
  //     return const RouteSettings(name: Routes.dashboard);
  //   }
  //   if (!isAuthenticated) {
  //     return const RouteSettings(name: Routes.login);
  //   }
  //   return null;
  // }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (_fakeAuth.isPremium.value) {
      return GetNavConfig.fromRoute(route.location ?? '');
    }
    return null;
    // return await super.redirectDelegate(route);
  }

  //This function will be called  before anything created we can use it to
  // change something about the page or give it new page
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }

  //This function will be called right before the Bindings are initialized.
  // Here we can change Bindings for this page.
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings);
  }

  //This function will be called right after the Bindings are initialized.
  // Here we can do something after  bindings created and before creating the page widget.
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page);
  }

  // Page build and widgets of page will be shown
  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }

  //This function will be called right after disposing all the related objects
  // (Controllers, views, ...) of the page.
  @override
  void onPageDispose() {
    super.onPageDispose();
  }
}
