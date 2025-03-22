import 'package:mkr/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gridelement extends StatelessWidget {
  final String text;
  final String image;
  final String true_false;
  void Function()? onTap;
  Gridelement(
      {super.key,
      required this.text,
      required this.image,
      this.onTap,
      required this.true_false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Image.asset(
                    fit: BoxFit.scaleDown,
                    true_false,
                    width: MediaQuery.sizeOf(context).width <= 200
                        ? 10.w
                        : MediaQuery.sizeOf(context).width <= 700
                            ? 30.w
                            : 10.w,
                    height:
                        MediaQuery.sizeOf(context).width <= 200 ? 10.h : 30.h,
                  ),
                ),
              ),
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.scaleDown,
                  width: 100.w,
                ),
              )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7))),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width > 850
                              ? 5.sp
                              : MediaQuery.sizeOf(context).width > 600
                                  ? 9.sp
                                  : 15.sp,
                          fontFamily: "cairo",
                          color: appcolors.maincolor,
                        ),
                      ),
                    ),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
