import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/auth_controller.dart';
import 'package:maskura_app/views/main_screen.dart';


import '../../widgets_common/background_widget.dart';
import '../../widgets_common/custom_button.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/logo_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.02).heightBox,
            logoWidget(),
            "Create Account with $appname"
                .text
                .fontFamily(titleFont)
                .white
                .size(25)
                .make(),
            15.heightBox,
            Obx(()=> Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  10.heightBox,
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  10.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPass: true),
                  10.heightBox,
                  customTextField(
                      title: retypePassword,
                      hint: retypePasswordHint,
                      controller: retypePasswordController,
                      isPass: true),
                  10.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: Colors.black)),
                          TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: Colors.black)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ): customButton(
                      title: signup,
                      color: isCheck == true ? redColor : lightGrey,
                      titleColor: whiteColor,
                      onPress: () async {
                        if (isCheck != false) {
                          controller.isLoading(true);
                          try {
                            await controller
                                .signupMethod(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                            }).then((value) {
                              VxToast.show(context, msg: "Account Created");
                              Get.offAll(() => const Home());
                            });
                          } catch (e) {
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isLoading(false);
                          }
                        }
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Already have an Account? ".text.color(Colors.black).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(15))
                  .width(context.screenWidth - 50)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
