import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget customButton({onPress, color, titleColor, title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(10),
    ),
    onPressed: onPress,
    child: Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontFamily: secondTitle,
      ),
    ),
  );
}