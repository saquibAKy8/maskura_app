import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/views/home_screen/item_details.dart';
import 'package:maskura_app/views/search_screen/search_screen.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';
import '../../controllers/product_controller.dart';
import 'package:maskura_app/controllers/home_controller.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerHome = Get.find<HomeController>();
    var controller = Get.find<ProductController>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  color: lightGrey,
                  child: TextFormField(
                    controller: controllerHome.searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.search).onTap(() {
                        if (controllerHome
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScreen(
                                title: controllerHome.searchController.text,
                              ));
                        }
                      }),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchHint,
                      hintStyle: const TextStyle(color: greyColor),
                    ),
                  ),
                ).box.outerShadowSm.make(),
                10.heightBox,
                StreamBuilder(
                    stream: FirestoreServices.allProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      } else {
                        var allProductData = snapshot.data!.docs;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allProductData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 300,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  allProductData[index]['p_img'][0],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.fill,
                                ),
                                const Spacer(),
                                "${allProductData[index]['p_name']}"
                                    .text
                                    .fontFamily(secondTitle)
                                    .make(),
                                10.heightBox,
                                "£${allProductData[index]['p_price']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(titleFont)
                                    .size(15)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 5))
                                .roundedSM
                                .padding(const EdgeInsets.all(15))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                    title: "${allProductData[index]['p_name']}",
                                    data: allProductData[index],
                                  ));
                            });
                          },
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
