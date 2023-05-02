import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/views/home_screen/item_details.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Product by that name found!".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filter = data
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                children: filter
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filter[index]['p_img'][0],
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                            "${filter[index]['p_name']}"
                                .text
                                .fontFamily(secondTitle)
                                .make(),
                            10.heightBox,
                            "£${filter[index]['p_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(titleFont)
                                .size(15)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .outerShadowMd
                            .margin(const EdgeInsets.symmetric(horizontal: 5))
                            .roundedSM
                            .padding(const EdgeInsets.all(15))
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: "${filter[index]['p_name']}",
                                data: filter[index],
                              ));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
