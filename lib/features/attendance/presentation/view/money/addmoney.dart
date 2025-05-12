import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/attendance/data/models/moneyrequest.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/moneyradio.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

class Addmoney extends StatefulWidget {
  @override
  State<Addmoney> createState() => _AddmoneyState();
}

class _AddmoneyState extends State<Addmoney> {
  TextEditingController notes = TextEditingController();
  TextEditingController moneypackage = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getdata() async {
    if (BlocProvider.of<WorkersCubit>(context).workersnames.isEmpty) {
      await BlocProvider.of<WorkersCubit>(context).getworkers();
    }
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "السلف والخصومات",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "cairo",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            margin: EdgeInsets.all(
              MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
              ),
            ),
            width: MediaQuery.sizeOf(context).width > 650
                ? MediaQuery.sizeOf(context).width * 0.4
                : double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 9),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    BlocBuilder<Attendancecuibt, Attendancestate>(
                      builder: (context, state) {
                        return Moneyradio(
                          firstradio: "credit",
                          secondradio: "debit",
                          firstradiotitle: "سلفه",
                          secondradiotitle: "خصم",
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "التاريخ",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: appcolors.maincolor,
                          fontFamily: "cairo",
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<DateCubit, DateState>(
                      builder: (context, state) {
                        return choosedate(
                          date: BlocProvider.of<DateCubit>(context).date2,
                          onPressed: () {
                            BlocProvider.of<DateCubit>(
                              context,
                            ).changedate2(context);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<WorkersCubit, WorkersState>(
                      builder: (context, state) {
                        if (state is getworkerloading) return loading();
                        if (state is getworkerfailure)
                          return Text(state.errormessage);
                        return Column(children: [
                          Container(
                              color: Color(0xff535C91),
                              child: Center(
                                  child: DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<WorkersCubit>(context)
                                        .workername,
                                items: BlocProvider.of<WorkersCubit>(context)
                                    .workersnames,
                                onChanged: (value) {
                                  BlocProvider.of<WorkersCubit>(context)
                                      .changeworker(value!);
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                    textAlign: TextAlign.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ))),
                        ]);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    custommytextform(
                      keyboardType: TextInputType.number,
                      controller: moneypackage,
                      hintText: "المبلغ",
                      val: "برجاء ادخال المبلغ ",
                    ),
                    SizedBox(height: 10),
                    custommytextform(
                      controller: notes,
                      hintText: "الملاحظات",
                      val: "برجاء ادخال اسم الملاجظات",
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<Attendancecuibt, Attendancestate>(
                      listener: (context, state) {
                        if (state is addmoneyfailure) {
                          showtoast(
                              message: state.errormessage,
                              toaststate: Toaststate.error,
                              context: context);
                        }
                        if (state is addmoneysuccess) {
                          notes.clear();
                          moneypackage.clear();
                          BlocProvider.of<WorkersCubit>(context)
                              .changeworker("اسم العامل");

                          showtoast(
                              message: state.successmessage,
                              toaststate: Toaststate.succes,
                              context: context);
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is addmoneyloading) return loading();
                        return custommaterialbutton(
                          button_name: "تسجيل",
                          onPressed: () {
                            if (BlocProvider.of<WorkersCubit>(context)
                                    .workername ==
                                "اسم العامل") {
                              showdialogerror(
                                  error: "برجاء اختيار اسم العامل",
                                  context: context);
                            } else if (BlocProvider.of<DateCubit>(context)
                                    .date2 ==
                                "اختر التاريخ") {
                              showdialogerror(
                                  error: "برجاء اختيار التاريخ",
                                  context: context);
                            } else {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<Attendancecuibt>(context).addmoney(
                                    money: moneyrequset(
                                        date:
                                            BlocProvider.of<DateCubit>(context)
                                                .date2,
                                        notes: notes.text,
                                        amount: moneypackage.text,
                                        type: BlocProvider.of<Attendancecuibt>(
                                                context)
                                            .moneyname,
                                        employer_id: BlocProvider.of<
                                                    WorkersCubit>(context)
                                                .workerid[
                                            BlocProvider.of<WorkersCubit>(
                                                    context)
                                                .workername]));
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
