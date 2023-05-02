import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/views/chat_screen/chat_screen.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Message History".text.fontFamily(secondTitle).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "You do not have any message history yet!"
                  .text
                  .fontFamily(secondTitle)
                  .size(16)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Get.to(() => const ChatScreen(),);
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(Icons.person, color: whiteColor,),
                                ),
                                title: intl.DateFormat('MMM dd, yyyy hh:mm a')
                                    .format(data[index]['created_on'].toDate())
                                    .text
                                    .fontFamily(secondTitle)
                                    .make(),
                                subtitle: "${data[index]['last_msg']}".text.make(),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
