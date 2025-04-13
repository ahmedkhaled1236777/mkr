import 'package:flutter/material.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/componentstore/data/models/componentmovemoddel/datum.dart';

class Componentmoveitem extends StatelessWidget {
  final datummoves componentitem;

  Componentmoveitem({super.key, required this.componentitem});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "${componentitem.date}",
            style: TextStyle(
                fontFamily: "cairo",
                fontSize: 12.5,
                color: appcolors.maincolor),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                Text("الكميه",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(componentitem.qty.toString(),
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                Text("النوع",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(
                    componentitem.status == 0
                        ? "سحب"
                        : componentitem.status == 1
                            ? "اضافه"
                            : "مرتجع",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
          ),
          if (componentitem.status != 0)
            SizedBox(
              height: 7,
            ),
          if (componentitem.status != 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("سعر القطعه",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(componentitem.price.toString(),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (componentitem.status != 0)
            SizedBox(
              height: 7,
            ),
          if (componentitem.status != 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  const Text("اسم المورد",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  const Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Expanded(
                    child: Text(componentitem.nameOfSupplier.toString(),
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: appcolors.maincolor)),
                  )
                ],
              ),
            ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("الملاحظات",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Expanded(
                  child: Text(componentitem.notes ?? "لا يوجد",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
