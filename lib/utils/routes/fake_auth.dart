import 'package:get/get.dart';

class FakeAuthService extends GetxService {
  Future<FakeAuthService> init() async => this;

  final RxBool isPremium = false.obs;

  void setIsPremium(bool newValue) {
    isPremium.value = newValue;
  }
}
