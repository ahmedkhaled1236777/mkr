import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';

class Alertsuppliersearch extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              custommytextform(
                controller: name,
                hintText: "اسم المورد",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                keyboardType: TextInputType.number,
                controller: phone,
                hintText: "رقم الهاتف",
              ),
              SizedBox(
                height: 35,
              ),
              custommaterialbutton(
                  button_name: "بحث",
                  onPressed: () async {
                    // ignore: await_only_futures
                    BlocProvider.of<supplierCubit>(context).queryparma = {
                      if (phone.text.isNotEmpty) "phone": phone.text,
                      if (name.text.isNotEmpty) "name": name.text
                    };
                    await BlocProvider.of<supplierCubit>(context)
                        .getsuppliers();
                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
