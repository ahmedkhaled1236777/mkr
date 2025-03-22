import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class custommaterialbutton extends StatelessWidget {
  final void Function()? onPressed;
  // ignore: non_constant_identifier_names
  final String button_name;
  // ignore: non_constant_identifier_names
  const custommaterialbutton({
    super.key,
    this.onPressed,
    required this.button_name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          color: appcolors.primarycolor,
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width > 950 ? 20 : 15),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              button_name,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: apptexts.appfonfamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
