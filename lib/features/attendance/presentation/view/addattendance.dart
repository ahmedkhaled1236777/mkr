import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/radios.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class Addattendance extends StatefulWidget {
  @override
  State<Addattendance> createState() => _AddattendanceState();
}

class _AddattendanceState extends State<Addattendance> {
  getdata() async {
    await BlocProvider.of<Attendancecuibt>(context).getaattendance(queryparma: {
      "month": DateTime.now().month,
      "year": DateTime.now().year
    });
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "تسجيل الحضور",
          style: Styles.appbarstyle,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/home.png",
                ))),
        child: Center(
          child: BlocBuilder<Attendancecuibt, Attendancestate>(
            builder: (context, state) {
              return BlocProvider.of<Attendancecuibt>(context)
                      .attendances
                      .isEmpty
                  ? nodata()
                  : Container(
                      height: MediaQuery.sizeOf(context).height,
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 9),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date2,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate2(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${BlocProvider.of<Attendancecuibt>(context).workersnames[index]} ",
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              color: appcolors.maincolor,
                                              fontFamily: "cairo"),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Expanded(
                                        child: Attendanceradio(
                                            index: index,
                                            firstradio: "حضور",
                                            secondradio: "غياب",
                                            thirdradio: "اجازه",
                                            groupvalue: BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .status[index],
                                            firstradiotitle: "حضور",
                                            thirdradiotittle: "اجازه",
                                            secondradiotitle: "غياب"),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, i) => Divider(
                                  color: Colors.grey,
                                ),
                                itemCount:
                                    BlocProvider.of<Attendancecuibt>(context)
                                        .status
                                        .length,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            BlocConsumer<Attendancecuibt, Attendancestate>(
                              listener: (context, state) async {
                                if (state is addattendancefailure)
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                if (state is addattendancesuccess) {
                                  await BlocProvider.of<Attendancecuibt>(
                                          context)
                                      .getaattendance(queryparma: {
                                    "month": DateTime.now().month,
                                    "year": DateTime.now().year
                                  });
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addattendanceloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (BlocProvider.of<DateCubit>(context)
                                            .date2 ==
                                        "اختر التاريخ") {
                                      showdialogerror(
                                          error: "لابد من اختيار التاريخ",
                                          context: context);
                                    } else {
                                      List attendances = [];
                                      for (int i = 0;
                                          i <
                                              BlocProvider.of<Attendancecuibt>(
                                                      context)
                                                  .attendances
                                                  .length;
                                          i++) {
                                        attendances.add({
                                          "employer_id":
                                              BlocProvider.of<Attendancecuibt>(
                                                      context)
                                                  .attendances[i]
                                                  .id,
                                          "status": BlocProvider.of<
                                                              Attendancecuibt>(
                                                          context)
                                                      .status[i] ==
                                                  "اجازه"
                                              ? 0
                                              : BlocProvider.of<Attendancecuibt>(
                                                              context)
                                                          .status[i] ==
                                                      "حضور"
                                                  ? 1
                                                  : 2
                                        });
                                      }
                                      await BlocProvider.of<Attendancecuibt>(
                                              context)
                                          .addworker(
                                              attendance:
                                                  Attendancemodelrequest(
                                                      date: BlocProvider.of<
                                                                  DateCubit>(
                                                              context)
                                                          .date2,
                                                      attendance: attendances));
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      ));
            },
          ),
        ),
      ),
    );
  }
}
