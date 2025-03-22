import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/componentstore/data/models/componentmodelrequest.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';

class editcomponentdialog extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController componentname = TextEditingController();
  TextEditingController packtype = TextEditingController();
  TextEditingController qtyinpack = TextEditingController();
  TextEditingController alarm = TextEditingController();
  final int id;
  final String quantity;

  editcomponentdialog(
      {super.key,
      required this.componentname,
      required this.quantity,
      required this.packtype,
      required this.qtyinpack,
      required this.alarm,
      required this.id});
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
            custommytextform(
              controller: componentname,
              hintText: "اسم المكون",
              val: "برجاء ادخال اسم المكون",
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
                        FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
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
                        FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
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
            SizedBox(
              height: 15,
            ),
            BlocConsumer<ComponentCubit, ComponentState>(
              listener: (context, state) {
                if (state is editcomponentfailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is editcomponentsuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<ComponentCubit>(context).getcomponents();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is editcomponentloading) return loading();
                return custommaterialbutton(
                  button_name: "تسجيل مكون",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<ComponentCubit>(context).editcoponent(
                          id: id,
                          component: Componentmodelrequest(
                              componentname: componentname.text,
                              quantity: quantity,
                              alarmqty: alarm.text,
                              packtype: packtype.text,
                              qtyinpack: qtyinpack.text));
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
