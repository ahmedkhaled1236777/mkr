import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/users/presentation/views/widgets/addemployee.dart';
import 'package:flutter/material.dart';

class addemployeewithscafold extends StatelessWidget {
  GlobalKey<FormState> foemkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "تسجيل موظفين",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: addemplyee(
          formkey: foemkey,
          width: MediaQuery.sizeOf(context).width,
        )),
      ),
    );
  }
}
