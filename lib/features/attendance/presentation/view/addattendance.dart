import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/radios.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class Addattendance extends StatelessWidget {
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
          child: Container(
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
                          date: BlocProvider.of<DateCubit>(context).date1,
                          onPressed: () {
                            BlocProvider.of<DateCubit>(context)
                                .changedate(context);
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
                          return BlocBuilder<Attendancecuibt, Attendancestate>(
                              builder: (context, state) {
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
                                      groupvalue:
                                          BlocProvider.of<Attendancecuibt>(
                                                  context)
                                              .status[index],
                                      firstradiotitle: "حضور",
                                      thirdradiotittle: "اجازه",
                                      secondradiotitle: "غياب"),
                                ),
                              ],
                            );
                          });
                        },
                        separatorBuilder: (context, i) => Divider(
                          color: Colors.grey,
                        ),
                        itemCount: BlocProvider.of<Attendancecuibt>(context)
                            .status
                            .length,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    custommaterialbutton(button_name: "تسجيل"),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
