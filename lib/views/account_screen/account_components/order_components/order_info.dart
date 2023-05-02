import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget orderInfo({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(secondTitle).make(),
            "$d1"
                .text
                .color(redColor)
                .fontFamily(secondTitle)
                .make()
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(secondTitle).make(),
              "$d2"
                  .text
                  .make()
            ],
          ),
        ),
      ],
    ),
  );
}
