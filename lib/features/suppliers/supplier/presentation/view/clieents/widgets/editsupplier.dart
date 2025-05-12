import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/suppliers/supplier/data/models/supplierrequest.dart';
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';

class editsupplierdialog extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController suppliername = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController destenation = TextEditingController();

  final int id;

  editsupplierdialog(
      {super.key,
      required this.suppliername,
      required this.destenation,
      required this.phone,
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
              controller: suppliername,
              hintText: "اسم العميل",
              val: "برجاء ادخال اسم العميل",
            ),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
              ],
              keyboardType: TextInputType.number,
              controller: phone,
              hintText: "رقم هاتف العميل",
              val: "برجاء ادخال رقم هاتف العميل",
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<supplierCubit, supplierState>(
              listener: (context, state) {
                if (state is editsupplierfailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is editsuppliersuccess) {
                  Navigator.pop(context);
                  BlocProvider.of<supplierCubit>(context).getsuppliers();
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is editsupplierloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل البيانات",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<supplierCubit>(context).editcoponent(
                          id: id,
                          supplier: supplierrequest(
                            destination: destenation.text,
                            pay: null,
                            process: null,
                            name: suppliername.text,
                            phone: phone.text,
                          ));
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
