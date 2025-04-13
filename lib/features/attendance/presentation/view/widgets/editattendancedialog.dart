import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/radios.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

class Editattendancedialog extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final String date;
  String? status;
  final String type;
  final String month;
  final String year;
  TextEditingController? permessionhours;
  TextEditingController? notes;
  final int moveid;
  final int employeid;

  Editattendancedialog(
      {super.key,
      required this.date,
      this.permessionhours,
      required this.month,
      this.status,
      this.notes,
      required this.type,
      required this.year,
      required this.moveid,
      required this.employeid});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("التاريخ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(date,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            if (type != "move")
              custommytextform(
                controller: permessionhours!,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
                ],
                keyboardType: TextInputType.number,
                hintText: "ساعات الاذن",
                val: "برجاء ادخال ساعات الاذن",
              ),
            const SizedBox(
              height: 10,
            ),
            if (type != "move")
              custommytextform(
                controller: notes!,
                hintText: "الملاحظات",
                val: "برجاء ادخال الملاحظات",
              ),
            const SizedBox(
              height: 10,
            ),
            if (type == "move")
              BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  return editAttendanceradio(
                      firstradio: "حضور",
                      secondradio: "غياب",
                      thirdradio: "اجازه",
                      groupvalue: BlocProvider.of<Attendancecuibt>(context)
                          .attendancestatus!,
                      firstradiotitle: "حضور",
                      thirdradiotittle: "اجازه",
                      secondradiotitle: "غياب");
                },
              ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<Attendancecuibt, Attendancestate>(
              listener: (context, state) {
                if (state is editattendancefailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is editattendencesuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<WorkersCubit>(context).getworkersmoves(
                      workerid: employeid, month: month, year: year);
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is editattendanceloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل البيانات",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (type == "move") {
                        BlocProvider.of<Attendancecuibt>(context)
                            .editatttendancemove(
                                status: BlocProvider.of<Attendancecuibt>(
                                                context)
                                            .attendancestatus ==
                                        "حضور"
                                    ? "1"
                                    : BlocProvider.of<Attendancecuibt>(context)
                                                .attendancestatus ==
                                            "اجازه"
                                        ? "0"
                                        : "2",
                                id: moveid);
                      } else {
                        BlocProvider.of<Attendancecuibt>(context)
                            .editpermession(
                                attendance: Attendancepermessionrequest(
                                    status: "0",
                                    employerid: employeid,
                                    numberofhours: permessionhours!.text,
                                    date: date,
                                    notes: notes!.text),
                                id: moveid);
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
