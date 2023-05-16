

import 'package:get/get.dart';
import 'package:trcmapping/controllers/auth/auth_controller.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {

    Get.put(AuthController(), permanent:true);
  }
}