import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/cart_controller.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/views/cart_screen/shipping_screen.dart';
import 'package:maskura_app/widgets_common/custom_button.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 50,
          child: customButton(
            color: redColor,
            onPress: () {
              Get.to(() => const ShippingDetails());
            },
            titleColor: whiteColor,
            title: "Proceed to Shipping",
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Your Cart".text.fontFamily(secondTitle).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.size(20).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    '${data[index]['img']}',
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(secondTitle)
                                          .size(15)
                                          .make(),
                                  subtitle: "£${data[index]['tprice']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(titleFont)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  }),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price".text.fontFamily(titleFont).make(),
                          Obx(
                            () => "£${controller.totalP.value}"
                                .text
                                .fontFamily(titleFont)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10))
                          .color(lightYellow)
                          .width(context.screenWidth - 50)
                          .roundedSM
                          .make(),
                    ],
                  ),
                );
              }
            }));
  }
}