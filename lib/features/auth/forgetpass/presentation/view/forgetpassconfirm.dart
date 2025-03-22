import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:flutter/material.dart';

class Forgetpassconfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset("assets/images/app/Illustration.png"),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "تم ارسال رسالة التأكيد للبريد الالكتروني",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "alex"),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Center(
                child: Text(
                  "من فضلك افحص ايميلك واتبع التعليمات لاعادة تعيين كلمة المرور الخاصه بك",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appcolors.lighttext,
                      fontSize: 10,
                      fontFamily: "alex"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              custommaterialbutton(button_name: "العوده للتسجيل الدخول"),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
