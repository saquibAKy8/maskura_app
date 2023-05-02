import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/controllers/account_controller.dart';
import 'package:maskura_app/widgets_common/background_widget.dart';
import 'package:maskura_app/widgets_common/custom_button.dart';
import 'package:maskura_app/widgets_common/custom_textfield.dart';

import '../../consts/consts.dart';

class EditAccountScreen extends StatelessWidget {
  final dynamic data;
  const EditAccountScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AccountController>();

    return backgroundWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.accountImgPath.isEmpty
                  ? Image.asset(
                      profileImg,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.accountImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.accountImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              customButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  titleColor: whiteColor,
                  title: "Change Picture"),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldpassController,
                hint: "Enter your current password",
                title: "Current Password",
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newpassController,
                hint: "Enter your new password",
                title: "New Password",
                isPass: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 50,
                      child: customButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);
                            if(controller.accountImgPath.value.isNotEmpty){
                              await controller.uploadAccountImage();
                            }else{
                              controller.accountImageLink = data['imageUrl'];
                            }
                            if(data['password'] == controller.oldpassController.text){
                              await controller.changeAuthpassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text,
                              );
                              await controller.updateAccount(
                              imgUrl: controller.accountImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Account Updated");
                            }else {
                              VxToast.show(context, msg: "Incorrect current password");
                              controller.isLoading(false);
                            }
                          },
                          titleColor: whiteColor,
                          title: "Save Changes"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(15))
              .margin(const EdgeInsets.only(top: 50, left: 10, right: 10))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
