import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/texts.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform%20copy%202.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/auth/login/data/model/loginrequest.dart';
import 'package:mkr/features/auth/login/presentation/view/signup.dart';
import 'package:mkr/features/auth/login/presentation/view/widgets/noaccount.dart';
import 'package:mkr/features/auth/login/presentation/viewmodel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/home/presentation/view/home2.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width > 600
                  ? MediaQuery.sizeOf(context).width * 0.4
                  : double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      fit: BoxFit.fitHeight,
                      "assets/images/logo.jpeg",
                      height: 160,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontFamily: apptexts.appfonfamily, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customtextform(
                        controller: email, hintText: "البريد الالكتروني"),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return customtextform(
                          obscureText:
                              BlocProvider.of<AuthCubit>(context).obsecure,
                          controller: password,
                          hintText: "كلمة المرور",
                          suffixIcon: IconButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .changeobsecure();
                              },
                              icon: Icon(
                                BlocProvider.of<AuthCubit>(context).obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: appcolors.lighttext,
                              )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is loginfailure)
                          showtoast(
                              message: state.errormessage,
                              toaststate: Toaststate.error,
                              context: context);
                        if (state is loginsuccess) {
                          navigateandfinish(context: context, page: home2());
                          showtoast(
                              message: state.successmessage,
                              toaststate: Toaststate.succes,
                              context: context);
                        }
                      },
                      builder: (context, state) {
                        if (state is loginloading) return loading();
                        return custommaterialbutton(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).login(
                                  login: loginrequest(
                                password: password.text,
                                email: email.text,
                              ));
                            },
                            button_name: "تسجيل الدخول");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /* TextButton(
                        onPressed: () {
                          navigateto(context: context, page: Forgetpass());
                        },
                        child: Text(
                          "نسيت كلمة المرور ؟",
                          style: TextStyle(
                              fontFamily: apptexts.appfonfamily,
                              color: appcolors.maincolors,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),*/
                    const SizedBox(
                      height: 15,
                    ),
                    noaccount(
                        maintext: "لم تمتلك حساب بعد ؟",
                        buttontext: "انشاء حساب",
                        navigated_widget: Signup())
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
