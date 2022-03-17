import 'package:dofsweb/services/user_session.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final session = UserSession();

  @override
  void onReady() {
    init();
    super.onReady();
  }

  void init() async {
    final user = await session.getSession();
    print(user);
    if (user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
