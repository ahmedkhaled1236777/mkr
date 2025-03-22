import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/texts.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class customtextform extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  Widget? suffixIcon;
  String? val;
  TextInputType keyboardType;
  int? maxlines;
  bool? readonly;
  String? suffixtext;
  Widget? prefixicon;
  void Function(String)? onChanged;

  List<TextInputFormatter>? inputFormatters;

  customtextform(
      {super.key,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.val,
      this.prefixicon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        shadowColor: appcolors.lighttext,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: BorderSide(
              color: appcolors.textform,
            )),
        elevation: 2,
        child: TextFormField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: (value) {
            if (value!.isEmpty) {
              return val;
            }
          },
          obscureText: obscureText,
          style: TextStyle(fontSize: 12.5),
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: this.prefixicon,
              contentPadding: EdgeInsets.all(18),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide:
                      BorderSide(color: appcolors.textform, width: 0.5)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide:
                      BorderSide(color: appcolors.textform, width: 0.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide:
                      BorderSide(color: appcolors.textform, width: 0.5)),
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                fontFamily: apptexts.appfonfamily,
                color: appcolors.lighttext,
              )),
        ),
      ),
    );
  }
}
