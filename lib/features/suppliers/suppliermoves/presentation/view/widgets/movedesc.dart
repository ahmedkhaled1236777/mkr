import 'package:flutter/material.dart';
import 'package:mkr/core/colors/colors.dart';

import '../../../data/models/suppliermovemodel/datum.dart';

class suppliermoveitem extends StatelessWidget {
  final datummoves suppliermove;

  suppliermoveitem({super.key, required this.suppliermove});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "${suppliermove.date}",
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
                Text(suppliermove.status == 0 ? "عمليه" : "دفع مبلغ",
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
          if (suppliermove.status == 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  if (suppliermove.status == 0)
                    Text("اسم المنتج",
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(suppliermove.stockId.toString() ?? "لا يوجد",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (suppliermove.status == 0)
            SizedBox(
              height: 7,
            ),
          if (suppliermove.status == 0)
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
                  Text("${suppliermove.qty} ${suppliermove.stockId.toString()}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (suppliermove.status == 0)
            SizedBox(
              height: 7,
            ),
          if (suppliermove.status == 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("الكميه داخل ${""}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text("${suppliermove.unitsPerPackaging}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (suppliermove.status == 0)
            SizedBox(
              height: 7,
            ),
          if (suppliermove.status == 0)
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
                  Text("${suppliermove.price}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (suppliermove.status == 0)
            SizedBox(
              height: 7,
            ),
          if (suppliermove.status == 0)
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
                      (suppliermove.qty! *
                              double.parse(suppliermove.price!) *
                              suppliermove.unitsPerPackaging!)
                          .toStringAsFixed(1),
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
          if (suppliermove.status == 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  const Text("المبلغ المدفوع",
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
                    child: Text(suppliermove.price.toString(),
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
                  child: Text(suppliermove.notes ?? "لا يوجد",
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
