import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/cart_controller.dart';
import 'package:maskura_app/views/main_screen.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

import '../../widgets_common/custom_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
          backgroundColor: whiteColor,
          bottomNavigationBar: SizedBox(
            height: 50,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : customButton(
                    onPress: () async{
                      await controller.placeMyOrder(
                          totalAmount: controller.totalP.value);
                          await controller.clearCart();
                          VxToast.show(context, msg: "Order placed successfully");
                          Get.offAll(const Home());
                    },
                    color: redColor,
                    titleColor: whiteColor,
                    title: "Place my Order",
                  ),
          ),
          appBar: AppBar(
            title: "Payment Detail".text.fontFamily(secondTitle).make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              //children: [],
            ),
          )),
    );
  }
}
