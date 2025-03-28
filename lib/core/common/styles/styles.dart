import 'package:mkr/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static const TextStyle textstle13 = TextStyle(
    fontFamily: "cairo",
    fontSize: 12.5,
    color: Color(0xff2ba4c8),
    fontWeight: FontWeight.w100,
  );
  static TextStyle textStyle13w = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 3.sp.clamp(0, 3.sp));
  static TextStyle textStyle13wdd = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: "cairo",
      fontSize: 3.6.sp.clamp(0, 3.6.sp));
  static TextStyle textStyle13wd = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 3.5.sp,
      fontFamily: "cairo");
  static TextStyle textStyle14wm =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14);
  static TextStyle textStyle14wt = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10.sp);
  static const TextStyle textStyle12 = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: "cairo");
  static const TextStyle textStyle12b = const TextStyle(
      fontSize: 12.5,
      color: appcolors.maincolor,
      fontFamily: "cairo",
      fontWeight: FontWeight.bold);
  static const TextStyle textStyle15 =
      TextStyle(fontSize: 15, color: Colors.white, fontFamily: "cairo");
  static gettabletextstyle({required BuildContext context}) {
    return MediaQuery.of(context).size.width > 950
        ? Styles.textStyle12b
            .copyWith(fontSize: 3.3.sp, fontWeight: FontWeight.bold)
        : MediaQuery.of(context).size.width > 600
            ? Styles.textStyle12b
                .copyWith(fontSize: 6.sp, fontWeight: FontWeight.bold)
            : Styles.textStyle12b
                .copyWith(fontSize: 10.sp, fontWeight: FontWeight.bold);
  }

  static getheadertextstyle({required BuildContext context}) {
    return MediaQuery.of(context).size.width > 950
        ? Styles.textStyle13wdd
        : MediaQuery.of(context).size.width < 950 &&
                MediaQuery.of(context).size.width > 600
            ? Styles.textStyle13wd
                .copyWith(fontSize: 5.sp, fontWeight: FontWeight.bold)
            : Styles.textStyle13wd.copyWith(fontSize: 12.sp);
  }

  static const TextStyle appbarstyle = TextStyle(
      color: Colors.white,
      fontFamily: "cairo",
      fontSize: 15,
      fontWeight: FontWeight.bold);
}
