import "package:flutter/material.dart";
import "package:maskura_app/consts/consts.dart";

Widget backgroundWidget({Widget? child}){
  return Container(
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(bgScreen),fit: BoxFit.fill)),
    child: child,
  );
}