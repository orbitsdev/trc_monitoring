

import 'package:get/get.dart';
import 'package:trcmapping/database/role_seeder.dart';
import 'package:trcmapping/models/role.dart';

class AuthController extends GetxController{

      var roles = rolesdata.obs;
      Role? selectedRole;
      
      void updateRole(index){

          for (var role in roles) {
              role.isSelected =false;
          }

          roles[index].isSelected = true;
          Role choiceRole = roles[index];
          selectedRole = choiceRole;
          update();


      }

}