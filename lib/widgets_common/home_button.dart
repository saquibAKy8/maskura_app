import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 25,
      ),
      10.heightBox,
      title!.text.fontFamily(titleFont).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}