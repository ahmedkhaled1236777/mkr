import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/workers/data/models/workermodelrequest.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

import '../../../../../core/common/date/date_cubit.dart';

class editworkerdialog extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController jop = TextEditingController();
  TextEditingController workhours = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController salary = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final int id;

  editworkerdialog(
      {super.key,
      required this.name,
      required this.jop,
      required this.workhours,
      required this.salary,
      required this.phone,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width > 950
                    ? MediaQuery.sizeOf(context).width * 0.25
                    : MediaQuery.sizeOf(context).width * 1,
                child: BlocBuilder<DateCubit, DateState>(
                  builder: (context, state) {
                    return choosedate(
                      date: BlocProvider.of<DateCubit>(context).date2,
                      onPressed: () {
                        BlocProvider.of<DateCubit>(context)
                            .changedate2(context);
                      },
                    );
                  },
                ),
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
                  FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
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
                  FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
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
                  if (state is editworkerfailure) {
                    showtoast(
                        message: state.errormessage,
                        toaststate: Toaststate.error,
                        context: context);
                  }
                  if (state is editworkersuccess) {
                    Navigator.pop(context);
                    BlocProvider.of<WorkersCubit>(context).getworkers();
                    showtoast(
                        message: state.successmessage,
                        toaststate: Toaststate.succes,
                        context: context);
                  }
                },
                builder: (context, state) {
                  if (state is editworkerloading) return loading();
                  return custommaterialbutton(
                    button_name: "تعديل البيانات",
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<WorkersCubit>(context).editworker(
                            id: id,
                            worker: Workermodelrequest(
                                name: name.text,
                                phone: phone.text,
                                job_title: jop.text,
                                hourprice: (double.parse(salary.text) /
                                        (double.parse(workhours.text) * 30))
                                    .toStringAsFixed(1),
                                employment_date:
                                    BlocProvider.of<DateCubit>(context).date2,
                                workhours: workhours.text,
                                salary: salary.text));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
