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
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/componentstore/data/models/componentmoverequest.dart';
import 'package:mkr/features/componentstore/presentation/view/componentsmoves/widgets/componentsradio.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class Addcomponentmove extends StatefulWidget {
  final String packtype;
  final String prodname;
  final int prodid;

  Addcomponentmove(
      {super.key,
      required this.packtype,
      required this.prodname,
      required this.prodid});
  @override
  State<Addcomponentmove> createState() => _AddcomponentmoveState();
}

class _AddcomponentmoveState extends State<Addcomponentmove> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController nameofsupplier = TextEditingController();

  TextEditingController notes = TextEditingController();

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
                "اضافة حركة ${widget.prodname}",
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
                              height: 25,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
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
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                return Componentsradio(
                                  firstradio: "0",
                                  secondradio: "1",
                                  firstradiotitle: "سحب",
                                  secondradiotitle: "اضافه",
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9-.]")),
                              ],
                              keyboardType: TextInputType.number,
                              controller: qty,
                              hintText: "الكميه ب${widget.packtype}",
                              val: "برجاء ادخال الكميه",
                            ),
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                return Column(children: [
                                  if (BlocProvider.of<ComponentCubit>(context)
                                          .materialstatus ==
                                      "1")
                                    SizedBox(height: 10),
                                  if (BlocProvider.of<ComponentCubit>(context)
                                          .materialstatus ==
                                      "1")
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: price,
                                      hintText: "سعر القطعه",
                                      val: "برجاء ادخال سعر القطعه",
                                    ),
                                  if (BlocProvider.of<ComponentCubit>(context)
                                          .materialstatus ==
                                      "1")
                                    SizedBox(height: 10),
                                  if (BlocProvider.of<ComponentCubit>(context)
                                          .materialstatus ==
                                      "1")
                                    custommytextform(
                                      controller: nameofsupplier,
                                      hintText: "اسم المورد",
                                      val: "برجاء ادخال اسم المورد",
                                    ),
                                ]);
                              },
                            ),
                            SizedBox(height: 10),
                            custommytextform(
                              controller: notes,
                              hintText: "الملاحظات",
                              val: "برجاء ادخال الملاحظات",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<ComponentCubit, ComponentState>(
                              listener: (context, state) async {
                                if (state is addcomponentmovefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addcomponentmovesuccess) {
                                  qty.clear();
                                  nameofsupplier.clear();
                                  price.clear();
                                  notes.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<ComponentCubit>(context)
                                      .changematerialstatus("0");
                                  await BlocProvider.of<ComponentCubit>(context)
                                      .getcomponentmotion(
                                          compid: widget.prodid);
                                  BlocProvider.of<ComponentCubit>(context)
                                      .getcomponents();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addcomponentmoveloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate())
                                      BlocProvider.of<ComponentCubit>(context).addcoponentmove(
                                          component: Componentmoverequest(
                                              qty: qty.text,
                                              name_of_supplier:
                                                  BlocProvider.of<ComponentCubit>(context)
                                                              .materialstatus ==
                                                          "1"
                                                      ? nameofsupplier.text
                                                      : "لا يوجد",
                                              stock_id: widget.prodid,
                                              date: BlocProvider.of<DateCubit>(context)
                                                  .date1,
                                              status: BlocProvider.of<
                                                      ComponentCubit>(context)
                                                  .materialstatus,
                                              price:
                                                  BlocProvider.of<ComponentCubit>(context)
                                                              .materialstatus ==
                                                          "1"
                                                      ? price.text
                                                      : "1",
                                              notes: notes.text));
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
