import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/widgets/cashedimage.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/features/attendance/presentation/view/attendance.dart';
//import 'package:mkr/features/accessories/presentation/views/accessories.dart';
import 'package:mkr/features/auth/login/presentation/view/login.dart';
import 'package:mkr/features/auth/profile/profile.dart';
import 'package:mkr/features/clients/clieents/presentation/view/clients.dart';
import 'package:mkr/features/componentstore/presentation/view/components/components.dart';
import 'package:mkr/features/fullprodstore/presentation/view/fullprods/fullprods.dart';
import 'package:mkr/features/suppliers/supplier/presentation/view/clieents/suppliers.dart';
/*import 'package:mkr/features/components/presentation/views/components.dart';
import 'package:mkr/features/clients/presentation/view/widgets/customers/customers.dart';
import 'package:mkr/features/factorytools/presentation/views/factorytools.dart';
import 'package:mkr/features/moldmanufacture/presentation/view/molmanufacture.dart';*/
import 'package:mkr/features/users/presentation/views/widgets/employees.dart';
//import 'package:mkr/features/injection/presentation/view/production.dart';
import 'package:mkr/features/home/presentation/view/widgets/gridelement.dart';
/*import 'package:mkr/features/materiales/presentation/views/material.dart';
import 'package:mkr/features/orders/presentation/view/orders.dart';
import 'package:mkr/features/save/presentation/view/saves.dart';
import 'package:mkr/features/suppliers/presentation/view/suppliers.dart';
import 'package:mkr/features/wallets/presentation/view/wallets.dart';
import 'package:badges/badges.dart' as badges;*/
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mkr/features/workers/presentation/views/workers.dart';

class home2 extends StatelessWidget {
  List<dynamic> categories = cashhelper.getdata(key: "permessions");
  List homegrid = [
    {
      "name": "العملاء",
      "name-en": "client",
      "image": "assets/images/public-service.png",
      "page": client()
    },
    {
      "name": "الموردين",
      "name-en": "supplier",
      "image": "assets/images/manager.png",
      "page": supplier()
    },
    {
      "name": "مخزن المنتج التام",
      "name-en": "fullprod",
      "image": "assets/images/boxes.png",
      "page": fullprod()
    },
    {
      "name": "مخزن المكونات والخامات",
      "name-en": "component",
      "image": "assets/images/recycle.png",
      "page": component()
    },
    {
      "name": "الموظفين",
      "name-en": "workers",
      "image": "assets/images/division.png",
      "page": worker()
    },
    {
      "name": "الحضور والانصراف",
      "name-en": "settings",
      "image": "assets/images/fingerprint.png",
      "page": attendance()
    },
    {
      "name": "المستخدمين",
      "name-en": "users",
      "image": "assets/images/team.png",
      "page": users()
    },
    {
      "name": "الاعدادات",
      "name-en": "settings",
      "image": "assets/images/settings.png",
      "page": profile()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  cashhelper.getdata(key: "image") == null
                      ? Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: AvatarGlow(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 30.0,
                              backgroundImage: AssetImage(
                                'assets/images/logo.jpeg',
                              ),
                            ),
                          ),
                        )
                      : Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: AvatarGlow(
                            child: imagefromrequest(
                              url: cashhelper.getdata(key: "image"),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      cashhelper.getdata(key: "name"),
                      style: const TextStyle(
                        fontFamily: "cairo",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 1 / 0.8,
                  crossAxisCount: MediaQuery.sizeOf(context).width > 950
                      ? 6
                      : MediaQuery.sizeOf(context).width > 650
                          ? 4
                          : MediaQuery.sizeOf(context).width > 500
                              ? 3
                              : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: homegrid
                      .map((e) => Gridelement(
                            true_false: !categories.contains(e["name-en"])
                                ? "assets/images/cross.png"
                                : "assets/images/newone.png",
                            text: e["name"],
                            image: e["image"],
                            onTap: () {
                              !categories.contains(e["name-en"])
                                  ? showdialogerror(
                                      error: "ليس لديك صلاحية الدخول للصفحه",
                                      context: context)
                                  : navigateto(
                                      context: context, page: e["page"]);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/home.png",
                ))),
      ),
    );
  }
}
