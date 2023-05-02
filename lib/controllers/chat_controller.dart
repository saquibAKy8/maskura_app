import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/home_controller.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chat = firestore.collection(chatCollection);

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId() async {
    isLoading(true);
    await chat
        .where('users', isEqualTo: {
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chat.add({
              'created_on': null,
              'last_msg': '',
              'users': {currentId: null},
              'fromId': '',
              'sender_name': senderName,
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
        isLoading(false);
  }

  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      chat.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'fromId': currentId,
      });

      chat.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}