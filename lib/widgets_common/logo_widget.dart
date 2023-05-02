import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget logoWidget() {
  return Image.asset(logo)
      .box
      .transparent
      .size(150, 150)
      .padding(const EdgeInsets.all(10))
      .rounded
      .make();
}