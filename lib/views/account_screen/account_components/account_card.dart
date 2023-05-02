import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget accountCards({width, String? count, String? title}){
  return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  count!.text.fontFamily(secondTitle).size(15).make(),
                  5.heightBox,
                  title!.text.make()
                ],
              ).box.white.rounded.width(width).height(80).padding(const EdgeInsets.all(5)).make();
}