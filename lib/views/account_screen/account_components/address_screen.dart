import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maskura_app/consts/consts.dart';
//import 'package:maskura_app/services/firestore_services.dart';
import 'package:maskura_app/widgets_common/loading_indicator.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Addresses".text.fontFamily(secondTitle).make(),
      ),
      body: StreamBuilder(
        //stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "You have not given any address yet!".text.fontFamily(secondTitle).size(16).makeCentered();
          }else{
            return Container();
          }
        }
      ),
    );
  }
}