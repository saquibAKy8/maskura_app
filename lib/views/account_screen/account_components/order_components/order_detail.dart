import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/home_controller.dart';
import 'package:maskura_app/views/account_screen/account_components/order_components/order_info.dart';
import 'package:maskura_app/views/account_screen/account_components/order_components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetail extends StatelessWidget {
  final dynamic data;
  const OrderDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Order Details".text.fontFamily(secondTitle).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    orderStatus(
                        color: redColor,
                        icon: Icons.done,
                        title: "Order Placed",
                        showDone: data['order_placed']),
                    orderStatus(
                        color: Colors.blue,
                        icon: Icons.thumb_up,
                        title: "Order Confirmed",
                        showDone: data['order_confirmed']),
                    orderStatus(
                        color: Colors.yellow,
                        icon: Icons.car_crash,
                        title: "Order On Delivery",
                        showDone: data['order_on_delivery']),
                    orderStatus(
                        color: Colors.green,
                        icon: Icons.done_all,
                        title: "Order Delivered",
                        showDone: data['order_delivered']),
                    const Divider(),
                    10.heightBox,
                    Column(
                      children: [
                        orderInfo(
                          title1: "Order Code",
                          title2: "Name",
                          d1: data['order_code'],
                          d2: Get.find<HomeController>().username,
                        ),
                        orderInfo(
                          title1: "Order Date",
                          title2: "Phone",
                          d1: intl.DateFormat()
                              .add_yMMMd()
                              .format(data['order_date'].toDate()),
                          d2: data['order_by_phone'],
                        ),
                        orderInfo(
                          title1: "Payment Status",
                          title2: "Delivery Status",
                          d1: "Paid",
                          d2: "Order Placed",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Shipping Address"
                                      .text
                                      .fontFamily(secondTitle)
                                      .make(),
                                  "${data['order_by_address']}".text.make(),
                                  "${data['order_by_city']}".text.make(),
                                  "${data['order_by_country']}".text.make(),
                                  "${data['order_by_postalcode']}".text.make(),
                                ],
                              ),
                              SizedBox(
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Total Amount"
                                        .text
                                        .fontFamily(secondTitle)
                                        .make(),
                                    "£${data['total_amount']}"
                                        .text
                                        .color(redColor)
                                        .fontFamily(titleFont)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).box.white.shadowSm.make(),
                    const Divider(),
                    10.heightBox,
                    "Ordered Product"
                        .text
                        .size(15)
                        .fontFamily(secondTitle)
                        .makeCentered(),
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(data['orders'].length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderInfo(
                              title1: data['orders'][index]['title'],
                              title2: data['orders'][index]['tprice'],
                              d1: "x ${data['orders'][index]['qty']}",
                              d2: "refundable",
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                width: 30,
                                height: 20,
                                color: Color(data['orders'][index]['color']),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }).toList(),
                    ).box.white.shadowSm.make(),
                    20.heightBox,
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
