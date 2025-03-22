import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';

class fullprodsradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  fullprodsradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<fullprodCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.materialstatus,
              onChanged: (val) {
                customerbloc.changematerialstatus(val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.materialstatus,
              onChanged: (val) {
                customerbloc.changematerialstatus(val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
        ],
      ),
    );
  }
}
