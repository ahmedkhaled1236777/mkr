import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/features/auth/login/presentation/view/login.dart';
import 'package:mkr/features/home/presentation/view/home2.dart';

class LogoAnimationScreen extends StatefulWidget {
  const LogoAnimationScreen();

  @override
  LogoAnimationScreenState createState() => LogoAnimationScreenState();
}

class LogoAnimationScreenState extends State<LogoAnimationScreen> {
  int align = 0;
  bool showtext = false;

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 1500), () {
      setState(() {
        showtext = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
          ),
          AnimatedOpacity(
            onEnd: () async {
              cashhelper.getdata(key: "token") == null
                  ? navigateandfinish(context: context, page: Login())
                  : navigateandfinish(context: context, page: home2());
            },
            opacity: showtext ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: Container(
                child: Image.asset(
              "assets/images/logo.jpeg",
              width: 300,
              height: 300,
            )),
          ),
        ],
      ),
    ));
  }
}
