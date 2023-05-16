import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trcmapping/controllers/auth/auth_controller.dart';
import 'package:trcmapping/database/role_seeder.dart';
import 'package:trcmapping/helpers/asset.dart';
import 'package:trcmapping/modal/modal.dart';
import 'package:trcmapping/utils/themes/ap_constants.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/widgets/account_type_builder.dart';
import 'package:trcmapping/widgets/custome_progress_bar.dart';
import 'package:trcmapping/widgets/h.dart';
import 'package:trcmapping/widgets/v.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();

  int currentIndex = 0;
  late PageController _pageController;
  final ImagePicker picker = ImagePicker();
  File? _image;
  final _formKey = GlobalKey<FormBuilderState>();

  bool isPasswordShow = false;
  double progress = 0;
  bool stepOneIsComplete = false;
  bool stepTwoIsComplete = false;
  bool stepThreeIsComplete = false;


  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void next() {
    // _pageController.nextPage(curve: Curves.easeIn, duration: const Duration(milliseconds: 300));

    switch (currentIndex) {
      case 0:
        stepOneProcess();
        break;

      case 1:
        stepTwoProcess();
        break;

      case 2:
        stepTreeProcess();
        break;
    }
  }

  void selectRole(BuildContext context,int index) {
    authController.updateRole(index);

    if (authController.selectedRole != null) {
      setState(() {
        stepOneIsComplete = true;
      });
    }

  }

  stepOneProcess() {
    if (stepOneIsComplete) {
         _pageController.nextPage(curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
    }else{
        Modal.showErrorToast(context);
    }
  }

  stepTwoProcess() {
    
    if(_formKey.currentState!.validate()){
      setState((){
        stepTwoIsComplete = true;
        
      });

      _pageController.nextPage(curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
    }else{

       setState((){
       
        stepTwoIsComplete = false;
      });

    }

  }


  stepTreeProcess() {
      if(stepOneIsComplete == true && stepTwoIsComplete == true && stepThreeIsComplete == true){

          final firstName = _formKey.currentState!.fields['firstName']?.value;
          final lastName = _formKey.currentState!.fields['lastName']?.value;
          final email = _formKey.currentState!.fields['email']?.value;
          final password = _formKey.currentState!.fields['password']?.value;

          print(firstName);
          print(lastName);
          print(email);
          print(password);
          print(_image!.path);

      }else{
         print('your are missig sotmehing');
      }
  }

  void takePhoto() async {
    final photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
         stepThreeIsComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const H(16),
                      Expanded(
                        child: CustomProgressBar(
                          progress: (currentIndex + 1) / 3,
                          height: 8.0,
                          backgroundColor: AppColor.dotColor,
                          progressColor: AppColor.fontColorBlue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const H(20),
                      Text(
                        '${currentIndex + 1}/3',
                        style: TextStyle(),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 1300)),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).size.height * 0.20,
                child: PageView(
                    // physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: _pageController,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          V(MediaQuery.of(context).size.height * 0.05),
                          const Text('Select Your Account Type',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.fontColorPrimary),
                                  textAlign: TextAlign.center)
                              .animate()
                              .fadeIn(
                                  duration: const Duration(milliseconds: 1300)),
                          const V(16),
                          const Text(
                                  'Let\'s get started! What type of account would you like to create?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.fontColorSecondary),
                                  textAlign: TextAlign.center)
                              .animate()
                              .fadeIn(
                                  duration: const Duration(milliseconds: 1300)),
                          V(MediaQuery.of(context).size.height * 0.08),
                          GetBuilder<AuthController>(builder: (controller) {
                            return Expanded(
                              child: MasonryGridView.count(
                                itemCount: controller.roles.length,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 10,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => selectRole(context, index),
                                      child: AccountTypeBuilder(
                                              role: controller.roles[index])
                                          .animate()
                                          .fadeIn(
                                              duration:
                                                  const Duration(seconds: 1))
                                          .animate()
                                          .scale());
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: FormBuilder(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              V(MediaQuery.of(context).size.height * 0.05),
                              const Text('Fill in Your Details',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontColorPrimary),
                                      textAlign: TextAlign.center)
                                  .animate()
                                  .fadeIn(
                                      duration:
                                          const Duration(milliseconds: 1300)),
                              const V(16),
                              const Text(
                                      'We need some information to set up your account. Please provide the following details',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontColorSecondary),
                                      textAlign: TextAlign.center)
                                  .animate()
                                  .fadeIn(
                                      duration:
                                          const Duration(milliseconds: 1300)),
                              V(MediaQuery.of(context).size.height * 0.08),
                              FormBuilderTextField(
                                name: 'firstName',
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundColor,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius as needed
                                    borderSide: BorderSide(
                                      color: AppColor.fontColorSecondary,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: AppColor.fontColorPrimary),
                                  labelText: 'First Name',
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                              const V(16),
                              FormBuilderTextField(
                                name: 'lastName',
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundColor,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius as needed
                                    borderSide: BorderSide(
                                      color: AppColor.fontColorSecondary,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: AppColor.fontColorPrimary),
                                  labelText: 'Last Name',
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                              const V(16),
                              FormBuilderTextField(
                                name: 'email',
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundColor,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius as needed
                                    borderSide: BorderSide(
                                      color: AppColor.fontColorSecondary,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: AppColor.fontColorPrimary),
                                  labelText: 'Email',
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              const V(16),
                              FormBuilderTextField(
                                name: 'password',
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundColor,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the border radius as needed
                                    borderSide: BorderSide(
                                      color: AppColor.fontColorSecondary,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: AppColor.fontColorPrimary),
                                  labelText: 'Password',
                                ),
                                obscureText: !isPasswordShow,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(6),
                                ]),
                              ),
                              V(16),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      side: const BorderSide(
                                        color: Colors.blue,
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
                                      style: TextStyle(
                                          color: AppColor.darkprimary2)),
                                ],
                              )
                                  .animate()
                                  .fadeIn(duration: const Duration(seconds: 1)),
                              const V(16),
                              V(MediaQuery.of(context).size.height * 0.33),
                            ],
                          ),
                        ).animate().fadeIn(
                            duration: const Duration(milliseconds: 1300)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text('Add a Personal Touch',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.fontColorPrimary),
                                    textAlign: TextAlign.center)
                                .animate()
                                .fadeIn(
                                    duration:
                                        const Duration(milliseconds: 1300)),
                            const V(16),
                            const Text(
                                    'Let\'s make your profile stand out! Take a moment to capture a photo that represents you',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.fontColorSecondary),
                                    textAlign: TextAlign.center)
                                .animate()
                                .fadeIn(
                                    duration:
                                        const Duration(milliseconds: 1300)),
                            V(MediaQuery.of(context).size.height * 0.04),
                            _image != null
                                ? Image.file(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    _image!,
                                  )
                                    .animate()
                                    .moveY(
                                        begin: -30,
                                        end: 0,
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 1))
                                    .fadeIn()
                                : SvgPicture.asset(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    Asset.public('images/board.svg'),
                                  )
                                    .animate()
                                    .moveY(
                                        begin: -30,
                                        end: 0,
                                        curve: Curves.easeInOut,
                                        duration: const Duration(seconds: 1))
                                    .fadeIn(),
                            V(20),
                            ElevatedButton.icon(
                              onPressed: takePhoto,
                              icon: Icon(Icons.camera_alt),
                              label: Text('Take a Selfie'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            V(MediaQuery.of(context).size.height * 0.10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.18,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            const V(14),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: (currentIndex == 0 && stepOneIsComplete == false)
                    ? disabledButtonStyle
                    : (currentIndex == 1 && stepTwoIsComplete == false)
                        ? disabledButtonStyle
                        : (currentIndex == 2 && stepThreeIsComplete == false)
                            ? disabledButtonStyle
                            : enabledButtonStyle,
                onPressed: next,
                child: Text((stepOneIsComplete == true  && stepTwoIsComplete == true && stepThreeIsComplete == true) ? 'Sign Up'.toUpperCase()  :'Next'.toUpperCase(),
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
            const V(16),
            GestureDetector(
                onTap: () {},
                child: const Text('Login  to your existing account',
                    style: TextStyle(color: AppColor.fontColorBlue)))
          ],
        ),
      ),
    );
  }
}
