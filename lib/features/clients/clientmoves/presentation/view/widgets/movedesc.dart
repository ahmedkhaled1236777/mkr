import 'package:flutter/material.dart';
import 'package:mkr/core/colors/colors.dart';

import '../../../data/models/clientmovemodel/datum.dart';

class clientmoveitem extends StatelessWidget {
  final datummoves clientmove;

  clientmoveitem({super.key, required this.clientmove});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "${clientmove.date}",
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
                Text(
                    clientmove.status == "0"
                        ? "عمليه"
                        : clientmove.status == "1"
                            ? "دفع مبلغ"
                            : "مرتجع",
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
          if (clientmove.status != "1")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  if (clientmove.status != "1")
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
                  Expanded(
                    child: Text(clientmove.warehouseName ?? "لا يوجد",
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontSize: 12.5,
                            color: appcolors.maincolor)),
                  )
                ],
              ),
            ),
          if (clientmove.status != "1")
            SizedBox(
              height: 7,
            ),
          if (clientmove.status != "1")
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
                  Text("${clientmove.qty} ${clientmove.packagingType}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (clientmove.status != "1")
            SizedBox(
              height: 7,
            ),
          if (clientmove.status != "1")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("الكميه داخل ${clientmove.packagingType}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text("${clientmove.unitsPerPackaging}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (clientmove.status != "1")
            SizedBox(
              height: 7,
            ),
          if (clientmove.status != "1")
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
                  Text("${clientmove.price}",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (clientmove.status != "1")
            SizedBox(
              height: 7,
            ),
          if (clientmove.status != "1")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appcolors.primarycolor)),
              child: Row(
                children: [
                  Text("نسبة الخصم",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text(" : ",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor)),
                  Text("${clientmove.discountPercentage} %",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: appcolors.maincolor))
                ],
              ),
            ),
          if (clientmove.status != "1")
            SizedBox(
              height: 7,
            ),
          if (clientmove.status != "1")
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
                      (double.parse(clientmove.qty!) *
                              double.parse(clientmove.price!) *
                              double.parse(clientmove.unitsPerPackaging!) *
                              ((100 -
                                      double.parse(
                                          clientmove.discountPercentage!)) /
                                  100))
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
          if (clientmove.status == "1")
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
                    child: Text(clientmove.price.toString(),
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
                  child: Text(clientmove.notes ?? "لا يوجد",
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
