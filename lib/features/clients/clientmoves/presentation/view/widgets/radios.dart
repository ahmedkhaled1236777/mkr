import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';

class movesradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  movesradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.thirdradiotittle,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var actionbloc = BlocProvider.of<fullprodCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.primarycolor,
              value: firstradio,
              groupValue: actionbloc.type,
              onChanged: (val) {
                actionbloc.changetype(value: val!);
              }),
          Text(
            firstradiotitle,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.primarycolor,
              value: secondradio,
              groupValue: actionbloc.type,
              onChanged: (val) {
                actionbloc.changetype(value: val!);
              }),
          Text(
            secondradiotitle,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.primarycolor,
              value: thirdradio,
              groupValue: actionbloc.type,
              onChanged: (val) {
                actionbloc.changetype(value: val!);
              }),
          Text(
            thirdradiotittle,
          ),
        ],
      ),
    );
  }
}
