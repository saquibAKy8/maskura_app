import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(secondTitle).size(20).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: secondTitle,
              color: greyColor,
            ),
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: redColor,
            ))),
      ),
      5.heightBox,
    ],
  );
}