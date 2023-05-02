import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/views/authentication/signup_screen.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/auth_controller.dart';
import 'package:maskura_app/views/main_screen.dart';
import 'package:maskura_app/widgets_common/background_widget.dart';
import 'package:maskura_app/widgets_common/custom_button.dart';
import 'package:maskura_app/widgets_common/custom_textfield.dart';
import 'package:maskura_app/widgets_common/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return backgroundWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.02).heightBox,
            logoWidget(),
            "Login to $appname"
                .text
                .fontFamily(titleFont)
                .white
                .size(25)
                .make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController),
                  10.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  //5.heightBox,
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : customButton(
                          title: login,
                          color: redColor,
                          titleColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context,
                                    msg: "Logged in successfully");
                                Get.offAll(() => const Home());
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  20.heightBox,
                  createNewAccount.text.fontFamily(secondTitle).make(),
                  5.heightBox,
                  customButton(
                      title: createAccount,
                      color: lightYellow,
                      titleColor: redColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  20.heightBox,
                  loginWith.text.fontFamily(secondTitle).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
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
