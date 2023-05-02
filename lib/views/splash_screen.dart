import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maskura_app/views/authentication/login_screen.dart';
import 'package:maskura_app/consts/consts.dart';
import 'package:maskura_app/views/main_screen.dart';
import 'package:maskura_app/widgets_common/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  screenChange(){
    Future.delayed(const Duration(seconds: 3),(){
      Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(() => const LoginScreen());
        }else{
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    screenChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoWidget(),
              5.heightBox,
              appname.text.fontFamily(titleFont).size(30).black.make(),
            ],
          ),
        ),
      ),
    );
  }
}
