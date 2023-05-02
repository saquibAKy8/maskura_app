import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.fontFamily(secondTitle).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "You do not have any favorite product yet!"
                  .text
                  .fontFamily(secondTitle)
                  .size(16)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            '${data[index]['p_img'][0]}',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .fontFamily(secondTitle)
                              .size(15)
                              .make(),
                          subtitle: "£${data[index]['p_price']}"
                              .text
                              .color(redColor)
                              .fontFamily(titleFont)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ).onTap(() async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
