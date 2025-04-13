import 'package:flutter/material.dart';
import 'package:mkr/core/colors/colors.dart';

import '../../../../data/models/fullprodmovemodel/datum.dart';

class fullprodmoveitem extends StatelessWidget {
  final datummoves fullproditem;
  final String qtyintype;
  final String packtype;
  fullprodmoveitem(
      {super.key,
      required this.fullproditem,
      required this.qtyintype,
      required this.packtype});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "${fullproditem.date!}",
            style: TextStyle(
                fontFamily: "cairo",
                fontSize: 12.5,
                color: appcolors.maincolor),
          ),
          SizedBox(
            height: 15,
          ),
          if (fullproditem.status != 1)
            SizedBox(
              height: 7,
            ),
          if (fullproditem.status != 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  const Text("اسم العميل",
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
                    child: Text(fullproditem.nameOfClient.toString(),
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
                Text(fullproditem.qty.toString(),
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                SizedBox(
                  width: 5,
                ),
                Text(packtype,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
          ),
          if (fullproditem.status != 1)
            SizedBox(
              height: 7,
            ),
          if (fullproditem.status != 1)
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
                  Text(fullproditem.price.toString(),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (fullproditem.status != 1)
            SizedBox(
              height: 7,
            ),
          if (fullproditem.status != 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("نسبة الخصم %",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text("${fullproditem.discountPercentage}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (fullproditem.status != 1)
            SizedBox(
              height: 7,
            ),
          if (fullproditem.status != 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("اجمالى السعر",
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
                      "${((double.parse(fullproditem.price.toString()) * double.parse(qtyintype) * double.parse(fullproditem.qty.toString()) * (100 - double.parse(fullproditem.discountPercentage!))) / 100).toStringAsFixed(1)}",
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
                    fullproditem.status == 1
                        ? "اضافه"
                        : fullproditem.status == 0
                            ? "سحب"
                            : "اضافه",
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
                  child: Text(fullproditem.notes ?? "لا يوجد",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
