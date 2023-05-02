import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(const EdgeInsets.all(5)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: (Colors.green),
                )
              : Container(),
        ],
      ),
    ),
  );
}
