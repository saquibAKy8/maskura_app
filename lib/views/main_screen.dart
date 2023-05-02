import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/views/account_screen/account_screen.dart';
import 'package:maskura_app/views/cart_screen/cart_screen.dart';
import 'package:maskura_app/views/product_screen/product_screen.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/controllers/home_controller.dart';
import 'package:maskura_app/views/home_screen/home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            homeIcon,
            width: 25,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            productIcon,
            width: 25,
          ),
          label: "Products"),
      BottomNavigationBarItem(
          icon: Image.asset(
            cartIcon,
            width: 25,
          ),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(
            profileIcon,
            width: 25,
          ),
          label: "Account"),
    ];

    var navBody = [
      const HomeScreen(),
      const ProductScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: secondTitle),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItems,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
