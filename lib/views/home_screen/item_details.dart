import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/product_controller.dart';
import 'package:maskura_app/views/chat_screen/chat_screen.dart';
import 'package:maskura_app/widgets_common/custom_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.fontFamily(titleFont).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                      //controller.isFav(false);
                    } else {
                      controller.addToWishlist(data.id, context);
                      //controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: controller.isFav.value ? redColor : greyColor,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 300,
                        itemCount: data['p_img'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_img"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text.size(20).fontFamily(secondTitle).make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: greyColor,
                      selectionColor: goldColor,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "£${data['p_price']}"
                        .text
                        .color(redColor)
                        .fontFamily(titleFont)
                        .size(25)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_color'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(10)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(15)
                                        .fontFamily(titleFont)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(greyColor)
                                        .make(),
                                  ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(10)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.make(),
                              ),
                              "£${controller.totalPrice.value}"
                                  .text
                                  .color(redColor)
                                  .size(15)
                                  .fontFamily(titleFont)
                                  .make(),
                            ],
                          ).box.padding(const EdgeInsets.all(10)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    "Description".text.fontFamily(secondTitle).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Customer Support"
                                .text
                                .size(16)
                                .fontFamily(secondTitle)
                                .make(),
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: greyColor,
                          child: Icon(
                            Icons.message_rounded,
                            color: whiteColor,
                          ),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                          );
                        })
                      ],
                    )
                        .box
                        .white
                        .shadowSm
                        .padding(const EdgeInsets.all(8))
                        .roundedSM
                        .make(),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailsList.length,
                          (index) => ListTile(
                                title: itemDetailsList[index]
                                    .text
                                    .fontFamily(secondTitle)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    20.heightBox,
                    "Products you may also like"
                        .text
                        .fontFamily(secondTitle)
                        .size(15)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      cyclingProduct,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Cycle".text.fontFamily(secondTitle).make(),
                                    10.heightBox,
                                    "£50"
                                        .text
                                        .color(redColor)
                                        .fontFamily(titleFont)
                                        .size(15)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 5))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(10))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: customButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                        color: data['p_color'][controller.colorIndex.value],
                        context: context,
                        img: data['p_img'][0],
                        qty: controller.quantity.value,
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: "Added to cart");
                    }else{
                      VxToast.show(context, msg: "Quantity cannot be 0");
                    }
                  },
                  titleColor: whiteColor,
                  title: "Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
