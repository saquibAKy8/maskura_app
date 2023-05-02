import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maskura_app/views/account_screen/edit_account.dart';
import 'package:maskura_app/controllers/auth_controller.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/views/account_screen/account_components/account_card.dart';
import 'package:maskura_app/views/authentication/login_screen.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/account_controller.dart';
import 'package:maskura_app/widgets_common/background_widget.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

import 'account_components/address_screen.dart';
import 'account_components/message_screen.dart';
import 'account_components/order_screen.dart';
import 'account_components/wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AccountController());
    return backgroundWidget(
      child: Scaffold(
          body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];
            return SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: const Icon(
                        Icons.edit,
                        color: whiteColor,
                      ).onTap(() {
                        controller.nameController.text = data['name'];
                        Get.to(() => EditAccountScreen(data: data));
                      })),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              profileImg,
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(secondTitle)
                              .white
                              .make(),
                          "${data['email']}".text.white.make()
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: "Log Out"
                              .text
                              .fontFamily(secondTitle)
                              .white
                              .make())
                    ],
                  ),
                ),
                20.heightBox,
                FutureBuilder(
                    future: FirestoreServices.getCount(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            accountCards(
                                count: countData[0].toString(),
                                title: "Your Cart",
                                width: context.screenWidth / 3),
                            accountCards(
                                count: countData[1].toString(),
                                title: "Your Wishlist",
                                width: context.screenWidth / 3),
                          ],
                        );
                      }
                    }),
                30.heightBox,
                ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: greyColor,
                          );
                        },
                        itemCount: profileList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const AddressScreen());
                                  break;
                                case 1:
                                  //print(Colors.purple.value);
                                  Get.to(() => const OrderScreen());
                                  break;
                                case 2:
                                  Get.to(() => const WishlistScreen());
                                  break;
                                case 3:
                                  Get.to(() => const MessageScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileIconList[index],
                              width: 30,
                            ),
                            title: profileList[index]
                                .text
                                .fontFamily(secondTitle)
                                .make(),
                            //trailing: Image.asset(profileIconList[index], width: 30,),
                          );
                        })
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.symmetric(horizontal: 15))
                    .shadowSm
                    .make()
              ],
            ));
          }
        },
      )),
    );
  }
}
