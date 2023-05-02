import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;

  calculate(data){
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  placeMyOrder({required totalAmount}) async{
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "222435436565",
      'order_by': currentUser!.uid,
      'oder_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_country': countryController.text,
      'order_by_postalcode': postalcodeController.text,
      'order_by_phone': phoneController.text,
      'order_placed': true,
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_delivered': false,
      'total_amount': totalAmount,
      'order_date': FieldValue.serverTimestamp(),
      'orders': FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductDetails(){
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'tprice:': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCart(){
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}