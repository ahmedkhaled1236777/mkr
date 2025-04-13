import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';

class Attendanceradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final int index;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  final String groupvalue;
  Attendanceradio(
      {super.key,
      required this.firstradio,
      required this.index,
      required this.secondradio,
      required this.thirdradio,
      required this.groupvalue,
      required this.firstradiotitle,
      required this.thirdradiotittle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.primarycolor,
              value: firstradio,
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .changeattendancestatus(value: val!, index: index);
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
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .changeattendancestatus(value: val!, index: index);
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
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .changeattendancestatus(value: val!, index: index);
              }),
          Text(
            thirdradiotittle,
          ),
        ],
      ),
    );
  }
}

class editAttendanceradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  final String groupvalue;
  editAttendanceradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.groupvalue,
      required this.firstradiotitle,
      required this.thirdradiotittle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.primarycolor,
              value: firstradio,
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .editchangeattendancestatus(value: val!);
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
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .editchangeattendancestatus(value: val!);
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
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .editchangeattendancestatus(value: val!);
              }),
          Text(
            thirdradiotittle,
          ),
        ],
      ),
    );
  }
}
