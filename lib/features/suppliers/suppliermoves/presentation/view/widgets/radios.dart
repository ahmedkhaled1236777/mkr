import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class suppliermovesradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotitle;
  suppliermovesradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.thirdradiotitle,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var actionbloc = BlocProvider.of<ComponentCubit>(context);
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
            thirdradiotitle,
          ),
        ],
      ),
    );
  }
}
