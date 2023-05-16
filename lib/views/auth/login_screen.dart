import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trcmapping/helpers/asset.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/widgets/h.dart';
import 'package:trcmapping/widgets/v.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _focusScopeNode = FocusScopeNode();
  final _key = GlobalKey<FormState>();
  bool isPasswordShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    if (_key.currentState!.validate()) {
      print(_email.text);
      print(_password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkprimary,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _key,
          child: FocusScope(
            node: _focusScopeNode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                V(MediaQuery.of(context).size.height * 0.08),
                Container(),
                SvgPicture.asset(
                  height: MediaQuery.of(context).size.height * 0.28,
                  Asset.public('images/board.svg'),
                )
                    .animate()
                    .moveY(
                        begin: -30,
                        end: 0,
                        curve: Curves.easeInOut,
                        duration: const Duration(seconds: 1))
                    .fadeIn(),
                const V(50),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    
                    filled: true,
                    fillColor: AppColor.darkprimary2,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.darkprimary2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.darkprimary2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Email',
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email ';
                    }
                    return null;
                  },
                ).animate().fadeIn(duration: const Duration(seconds: 1)),
                const V(16),
                TextFormField(
                  obscureText: !isPasswordShow,
                  controller: _password,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.darkprimary2,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.darkprimary2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColor.darkprimary2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Password',
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password ';
                    }
                    return null;
                  },
                ).animate().fadeIn(duration: const Duration(seconds: 1)),
                const V(16),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                         side: const BorderSide(
          color: Colors.white,
        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              4.0), // Set the desired border radius here
                        ),
                        value: isPasswordShow,
                        onChanged: (newValue) {
                          setState(() {
                            isPasswordShow = newValue!;
                          });
                        },
                      ),
                    ),
                    const H(12),
                    const Text('Show password',
                        style: TextStyle(color: Colors.white)),
                  ],
                ).animate().fadeIn(duration: const Duration(seconds: 1)),
                const V(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.lightBlue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                ).animate().fadeIn(duration: const Duration(seconds: 1)),
 const V(16),
                RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: " Join Now ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Get.to(()=>  AccountSelectionScreen(), transition: Transition.cupertino);
                            },
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: const Duration(seconds: 1))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
