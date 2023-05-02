import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/controllers/product_controller.dart';
import 'package:maskura_app/views/home_screen/item_details.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/widgets_common/background_widget.dart';
import 'package:maskura_app/consts/consts.dart';

import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(titleFont).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subCat.length,
                  (index) => "${controller.subCat[index]}"
                          .text
                          .size(15)
                          .fontFamily(secondTitle)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(150, 50)
                          .margin(const EdgeInsets.symmetric(horizontal: 5))
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subCat[index]}");
                        setState(() {});
                      })),
            ),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: Center(
                    child: loadingIndicator(),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: "No products available right now!"
                      .text
                      .size(20)
                      .fontFamily(secondTitle)
                      .makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;
      
                return Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                //bagImg,
                                data[index]['p_img'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(secondTitle)
                                  .make(),
                              10.heightBox,
                              "£${data[index]['p_price']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(titleFont)
                                  .size(15)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(15))
                              .make()
                              .onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index],
                                ));
                          });
                        }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
