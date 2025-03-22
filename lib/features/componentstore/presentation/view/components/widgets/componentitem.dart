import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/features/componentstore/data/models/componentmodel/datum.dart';
import 'package:flutter/material.dart';

class Componentitem extends StatelessWidget {
  final Datum componentitem;

  const Componentitem({super.key, required this.componentitem});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "${componentitem.name}",
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
                Text("نوع التعبئه",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(componentitem.packagingType ?? "لا يوجد",
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
                Text("الكميه داخل النوع",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(componentitem.unitsPerPackaging.toString(),
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
                const Text("كمية التحذير",
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
                  child: Text(componentitem.warningQty.toString(),
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
