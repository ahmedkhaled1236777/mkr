import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/workers/data/models/workermodelrequest.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

class Addworker extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController jop = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController workhours = TextEditingController();
  TextEditingController salary = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "اضافة موظف",
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
                    child: Form(
                        key: formkey,
                        child: Container(
                            height: MediaQuery.sizeOf(context).height,
                            margin: EdgeInsets.all(
                                MediaQuery.sizeOf(context).width < 600
                                    ? 0
                                    : 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.sizeOf(context).width < 600
                                        ? 0
                                        : 15)),
                            width: MediaQuery.sizeOf(context).width > 650
                                ? MediaQuery.sizeOf(context).width * 0.4
                                : double.infinity,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 9),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "تاريخ التعيين",
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: appcolors.maincolor,
                                            fontFamily: "cairo"),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    BlocBuilder<DateCubit, DateState>(
                                      builder: (context, state) {
                                        return choosedate(
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
                                              .date2,
                                          onPressed: () {
                                            BlocProvider.of<DateCubit>(context)
                                                .changedate2(context);
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: name,
                                      hintText: "اسم الموظف",
                                      val: "برجاء ادخال اسم الموظف",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: phone,
                                      hintText: "رقم الهاتف",
                                      val: "برجاء ادخال رقم الهاتف",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: jop,
                                      hintText: "المسمى الوظيفي",
                                      val: "برجاء ادخال المسمى الوظيفي",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: workhours,
                                      hintText: "عدد ساعات العمل",
                                      val: "برجاء ادخال عدد ساعات العمل",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: salary,
                                      hintText: "الراتب",
                                      val: "برجاء ادخال الراتب",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BlocConsumer<WorkersCubit, WorkersState>(
                                      listener: (context, state) {
                                        if (state is addworkerfailure) {
                                          showtoast(
                                              message: state.errormessage,
                                              toaststate: Toaststate.error,
                                              context: context);
                                        }
                                        if (state is addworkersuccess) {
                                          name.clear();
                                          jop.clear();
                                          salary.clear();
                                          workhours.clear();
                                          phone.clear();
                                          BlocProvider.of<WorkersCubit>(context)
                                              .getworkers();
                                          BlocProvider.of<DateCubit>(context)
                                              .cleardates();
                                          showtoast(
                                              message: state.successmessage,
                                              toaststate: Toaststate.succes,
                                              context: context);
                                        }
                                        // TODO: implement listener
                                      },
                                      builder: (context, state) {
                                        if (state is addworkerloading)
                                          return loading();
                                        return custommaterialbutton(
                                          button_name: "تسجيل",
                                          onPressed: () {
                                            if (BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date2 ==
                                                "اختر التاريخ") {
                                              showdialogerror(
                                                  error: "برجاء اختيار التاريخ",
                                                  context: context);
                                            } else {
                                              if (formkey.currentState!.validate())
                                                BlocProvider.of<WorkersCubit>(context).addworker(
                                                    worker: Workermodelrequest(
                                                        name: name.text,
                                                        phone: phone.text,
                                                        job_title: jop.text,
                                                        hourprice: (double.parse(
                                                                    salary
                                                                        .text) /
                                                                (double.parse(workhours
                                                                        .text) *
                                                                    30))
                                                            .toStringAsFixed(1),
                                                        employment_date:
                                                            BlocProvider.of<DateCubit>(
                                                                    context)
                                                                .date2,
                                                        workhours: workhours.text,
                                                        salary: salary.text));
                                            }
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )))))))));
  }
}
