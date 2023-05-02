import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/cart_controller.dart';
import 'package:maskura_app/views/cart_screen/payment_screen.dart';
import 'package:maskura_app/widgets_common/custom_button.dart';
import 'package:maskura_app/widgets_common/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Details".text.fontFamily(secondTitle).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: customButton(
          onPress: () {
            Get.to(() => const PaymentMethod());
          },
          color: redColor,
          titleColor: whiteColor,
          title: "Checkout",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            customTextField(
                hint: "Enter your Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "Enter your City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "Enter your Country",
                isPass: false,
                title: "Country",
                controller: controller.countryController),
            customTextField(
                hint: "Enter your Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Enter your Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
