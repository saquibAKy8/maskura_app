import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/views/home_screen/categories_details.dart';

Widget featuredButton({String? title, img}) {
  return Row(
    children: [
      Image.asset(
        img,
        width: 100,
        height: 70,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(secondTitle).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 5))
      .white
      .padding(const EdgeInsets.all(5))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
        Get.to(() => CategoryDetails(title: title));
      });
}
