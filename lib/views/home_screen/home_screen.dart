import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/home_controller.dart';
import 'package:maskura_app/controllers/product_controller.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/views/home_screen/categories_details.dart';
import 'package:maskura_app/views/home_screen/home_components/featured_button.dart';
import 'package:maskura_app/views/home_screen/item_details.dart';
import 'package:maskura_app/views/search_screen/search_screen.dart';
import 'package:maskura_app/widgets_common/home_button.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerHome = Get.find<HomeController>();
    var controller = Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(10),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
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
                  hintStyle: const TextStyle(color: greyColor)),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 200,
                      enlargeCenterPage: true,
                      itemCount: swiperList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          swiperList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 5))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButton(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? newArrivalIcon : topSellerIcon,
                              title:
                                  index == 0 ? "New Arrival's" : "Top Seller",
                            )),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 200,
                      enlargeCenterPage: true,
                      itemCount: swiperSecondList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          swiperSecondList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 5))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButton(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? todaysDealIcon
                                  : index == 1
                                      ? topCategoriesIcon
                                      : comfortIcon,
                              title: index == 0
                                  ? "Today's Deal"
                                  : index == 1
                                      ? "Top Categories"
                                      : "Comfort",
                            )),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Featured Categories"
                        .text
                        .size(20)
                        .fontFamily(secondTitle)
                        .make(),
                  ),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      title: featuredCategoriesTitle1[index],
                                      img: featuredCategoriesImg1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      title: featuredCategoriesTitle2[index],
                                      img: featuredCategoriesImg2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Featured Product"
                            .text
                            .white
                            .fontFamily(titleFont)
                            .size(20)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                            stream: FirestoreServices.getFeaturedProducts(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return "No Featured Products available"
                                    .text
                                    .white
                                    .makeCentered();
                              } else {
                                var featuredData = snapshot.data!.docs;
                                return Row(
                                    children: List.generate(
                                  featuredData.length,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        featuredData[index]['p_img'][0],
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "${featuredData[index]['p_name']}"
                                          .text
                                          .fontFamily(secondTitle)
                                          .make(),
                                      10.heightBox,
                                      "£${featuredData[index]['p_price']}"
                                          //.numCurrency
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
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${featuredData[index]['p_name']}",
                                          data: featuredData[index],
                                        ));
                                  }),
                                ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Categories"
                              .text
                              .fontFamily(secondTitle)
                              .size(20)
                              .make(),
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 200),
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              Image.asset(
                                categoriesImg[index],
                                height: 120,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              categoriesList[index]
                                  .text
                                  .fontFamily(secondTitle)
                                  .align(TextAlign.center)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .rounded
                              .clip(Clip.antiAlias)
                              .outerShadowSm
                              .make()
                              .onTap(() {
                            controller.getSubCategories(categoriesList[index]);
                            Get.to(() =>
                                CategoryDetails(title: categoriesList[index]));
                          });
                        })),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
