import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/componentstore/data/models/componentmodelrequest.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class addcomponent extends StatefulWidget {
  @override
  State<addcomponent> createState() => _addcomponentState();
}

class _addcomponentState extends State<addcomponent> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController componentname = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController packtype = TextEditingController();
  TextEditingController qtyinpack = TextEditingController();
  TextEditingController alarm = TextEditingController();

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
                "اضافة مكون",
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
                            custommytextform(
                              controller: componentname,
                              hintText: "اسم المكون",
                              val: "برجاء ادخال اسم المكون",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              onChanged: (p0) {
                                BlocProvider.of<ComponentCubit>(context)
                                    .onpacktypechange();
                              },
                              controller: packtype,
                              hintText: "نوع التعبئه",
                              val:
                                  "(كيس او كرتونه...) برجاء ادخال نوع التعبئه ",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: qtyinpack,
                                      hintText: packtype.text.isEmpty
                                          ? "العدد داخل النوع"
                                          : "العدد داخل ${packtype.text}",
                                      val: "برجاء ادخال العدد داخل النوع",
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
                                      controller: quantity,
                                      hintText: packtype.text.isEmpty
                                          ? "الكميه"
                                          : "الكميه ب${packtype.text}",
                                      val: "برجاء ادخال الكميه",
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
                                      controller: alarm,
                                      hintText: packtype.text.isEmpty
                                          ? "كمية التحذير"
                                          : "كمية التحذير ب${packtype.text}",
                                      val: "برجاء ادخال كمية التحذير",
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<ComponentCubit, ComponentState>(
                              listener: (context, state) {
                                if (state is addcomponentfailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addcomponentsuccess) {
                                  qtyinpack.clear();
                                  componentname.clear();
                                  quantity.clear();
                                  alarm.clear();
                                  packtype.clear();
                                  BlocProvider.of<ComponentCubit>(context)
                                      .getcomponents();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addcomponentloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل مكون",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      BlocProvider.of<ComponentCubit>(context)
                                          .addcoponent(
                                              component: Componentmodelrequest(
                                                  componentname:
                                                      componentname.text,
                                                  quantity: quantity.text,
                                                  alarmqty: alarm.text,
                                                  packtype: packtype.text,
                                                  qtyinpack: qtyinpack.text));
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
