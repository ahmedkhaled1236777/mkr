import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/suppliers/data/models/supplierrequest.dart';
import 'package:mkr/features/suppliers/presentation/viewmodel/supplier/supplier_cubit.dart';

class addsupplier extends StatefulWidget {
  @override
  State<addsupplier> createState() => _addsupplierState();
}

class _addsupplierState extends State<addsupplier> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController suppliername = TextEditingController();
  TextEditingController phone = TextEditingController();

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
              title: const Text(
                "اضافة مورد",
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
                          child: SingleChildScrollView(
                              child: Column(children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Image.asset(
                              'assets/images/people.png',
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custommytextform(
                              controller: suppliername,
                              hintText: "اسم العميل",
                              val: "برجاء ادخال اسم العميل",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: phone,
                              hintText: "رقم هاتف العميل",
                              val: "برجاء ادخال رقم هاتف العميل",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<supplierCubit, supplierState>(
                              listener: (context, state) {
                                if (state is addsupplierfailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addsuppliersuccess) {
                                  phone.clear();
                                  suppliername.clear();

                                  BlocProvider.of<supplierCubit>(context)
                                      .getsuppliers();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addsupplierloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل مورد",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      BlocProvider.of<supplierCubit>(context)
                                          .addcoponent(
                                              supplier: supplierrequest(
                                        name: suppliername.text,
                                        phone: phone.text,
                                      ));
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
