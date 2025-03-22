import 'package:mkr/core/common/texts.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform%20copy%202.dart';
import 'package:flutter/material.dart';

class Forgetpass extends StatelessWidget {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "نسيت كلمة المرور",
            style: TextStyle(fontFamily: apptexts.appfonfamily, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              /* Text(
                  "تسجيل الدخول",
                  style:
                      TextStyle(fontFamily: apptexts.appfonfamily, fontSize: 20),
                ),*/
              Image.asset(
                fit: BoxFit.fitHeight,
                "assets/images/bag.png",
                height: 130,
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                "لا تقلق ادخل البريد الالكتروني الخاص بك حتي يتم ارسال لينك تستطيع من خلاله اعادة تعيين كلمة المرور",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: apptexts.appfonfamily),
              ),
              const SizedBox(
                height: 50,
              ),
              customtextform(
                controller: email,
                hintText: "البريد الالكتروني",
              ),
              const SizedBox(
                height: 45,
              ),
              const custommaterialbutton(button_name: "تأكيد"),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
