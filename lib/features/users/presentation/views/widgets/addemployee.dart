import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/users/data/models/addemployeerequest.dart';
import 'package:mkr/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:mkr/features/users/presentation/views/widgets/employees_powers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addemplyee extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final double width;

  addemplyee({super.key, required this.formkey, required this.width});

  @override
  State<addemplyee> createState() => _addemplyeeState();
}

class _addemplyeeState extends State<addemplyee> {
  TextEditingController employeename = TextEditingController();

  TextEditingController jobdescription = TextEditingController();

  TextEditingController passwordconfirm = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<AddemployeeCubit>(context).resetdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.sizeOf(context).width > 950
          ? MediaQuery.sizeOf(context).width * 0.35
          : MediaQuery.sizeOf(context).width * 1,
      color: Colors.white,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: Form(
        key: widget.formkey,
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        custommytextform(
                          controller: email,
                          hintText: "البريد الالكتروني",
                          val: "برجاء ادخال البريد الالكتروني",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          controller: employeename,
                          hintText: "اسم الموظف",
                          val: "برجاء ادخال اسم الموظف",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          controller: jobdescription,
                          hintText: "المسمي الوظيفي",
                          val: "برجاء ادخال المسمي الوظيفي",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9-.]")),
                          ],
                          keyboardType: TextInputType.number,
                          controller: phone,
                          hintText: "رقم الهاتف",
                          val: "برجاء ادخال رقم الهاتف",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          controller: password,
                          hintText: "كلمة المرور",
                          val: "برجاء ادخال كلمة المرور",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          controller: passwordconfirm,
                          hintText: "تاكيد كلمة المرور",
                          val: "برجاء تاكيد كلمة المرور",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 0.5)),
                          child: const EmployessPowers(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocConsumer<AddemployeeCubit, AddemployeeState>(
                          listener: (context, state) async {
                            if (state is Addemployeefailure) {
                              showtoast(
                                  toaststate: Toaststate.error,
                                  message: state.error_message,
                                  context: context);
                            }
                            if (state is Addemployeesuccess) {
                              BlocProvider.of<AddemployeeCubit>(context)
                                  .selecteditems
                                  .clear();
                              BlocProvider.of<AddemployeeCubit>(context).image =
                                  null;
                              employeename.clear();
                              email.clear();
                              passwordconfirm.clear();
                              jobdescription.clear();
                              password.clear();
                              phone.clear();

                              BlocProvider.of<showemployeescuibt>(context)
                                  .employeesdata
                                  .clear();
                              await BlocProvider.of<showemployeescuibt>(context)
                                  .getallemployees();
                              if (MediaQuery.sizeOf(context).width < 950)
                                Navigator.pop(context);
                              showtoast(
                                  toaststate: Toaststate.succes,
                                  message: state.succes_message,
                                  context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is Addemployeeloading) return loading();
                            return custommaterialbutton(
                              onPressed: (() async {
                                if (widget.formkey.currentState!.validate()) {
                                  if (BlocProvider.of<AddemployeeCubit>(context)
                                      .selecteditems
                                      .isEmpty) {
                                    showdialogerror(
                                        error: "يجب تحديد الصلاحيات",
                                        context: context);
                                  } else {
                                    await BlocProvider.of<AddemployeeCubit>(
                                            context)
                                        .addemployee(
                                            token: cashhelper.getdata(
                                                key: "token"),
                                            employee: addemployeemodel(
                                                email: email.text,
                                                password_confirmation:
                                                    passwordconfirm.text,
                                                password: password.text,
                                                name: employeename.text,
                                                phone: phone.text,
                                                jobtittle: jobdescription.text,
                                                permessions: BlocProvider.of<
                                                            AddemployeeCubit>(
                                                        context)
                                                    .getselecteditems()));
                                  }
                                }
                              }),
                              button_name: "تسجيل البيانات",
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
