import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trcmapping/binding/app_binding.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/views/auth/login_screen.dart';
import 'package:trcmapping/views/auth/register_screen.dart';
import 'package:trcmapping/views/start/boarding_screen.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
   AppBinding().dependencies();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  Widget authlogic(){
    return const RegisterScreen();
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
         fontFamily: 'ProductSans',
        colorSchemeSeed: AppColor.primary,
        useMaterial3: true,
         elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.primary),
        foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),
      
      ),
    ),
      ),
      home: authlogic(),
      getPages: [
        GetPage(name: '/boarding', page: ()=> const BoardingScreen()),
        GetPage(name: '/login', page: ()=> const LoginScreen() , transition:  Transition.cupertino),
        GetPage(name: '/register', page: ()=> const RegisterScreen() , transition:  Transition.cupertino),
      ],
    );
  }
}