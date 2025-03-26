import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/texts.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform%20copy%202.dart';
import 'package:mkr/features/auth/login/presentation/view/login.dart';
import 'package:mkr/features/auth/login/presentation/view/widgets/noaccount.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width > 600
                ? MediaQuery.sizeOf(context).width * 0.4
                : double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    /* Text(
                        "تسجيل الدخول",
                        style:
                            TextStyle(fontFamily: apptexts.appfonfamily, fontSize: 20),
                      ),*/
                    Image.asset(
                      fit: BoxFit.fill,
                      "assets/images/logo.jpeg",
                      height: 130,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "انشاء الحساب",
                        style: TextStyle(
                            fontFamily: apptexts.appfonfamily, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customtextform(controller: name, hintText: "الأسم"),
                    const SizedBox(
                      height: 24,
                    ),
                    customtextform(controller: phone, hintText: "رقم الهاتف"),
                    const SizedBox(
                      height: 24,
                    ),
                    customtextform(
                        controller: email, hintText: "البريد الالكتروني"),
                    const SizedBox(
                      height: 24,
                    ),
                    customtextform(
                      controller: password,
                      hintText: "كلمة المرور",
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility,
                            color: appcolors.lighttext,
                          )),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    const custommaterialbutton(button_name: "إنشاء حساب"),
                    const SizedBox(
                      height: 15,
                    ),
                    noaccount(
                        maintext: "تمتلك حساب ؟",
                        buttontext: "تسجيل دخول",
                        navigated_widget: Login())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
