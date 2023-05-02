import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/chat_controller.dart';

import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicator.dart';
import 'components/sender_chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Customer Support"
            .text
            .fontFamily(secondTitle)
            .color(Colors.black)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getChatMessages(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "No Message History".text.size(20).make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                  alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                                  child: senderChat(data)
                                  );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: lightGrey,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: lightGrey,
                      )),
                      hintText: "How may we help you today?"),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: redColor,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(10))
                .margin(const EdgeInsets.only(bottom: 10))
                .make(),
          ],
        ),
      ),
    );
  }
}
