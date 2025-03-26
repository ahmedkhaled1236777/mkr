import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/services/apiservice.dart';
import 'package:mkr/features/auth/login/data/repos/authrepoimp.dart';
import 'package:mkr/features/auth/login/presentation/view/login.dart';
import 'package:mkr/features/auth/login/presentation/viewmodel/cubit/auth_cubit.dart';
import 'package:mkr/features/clients/clieents/data/repos/clientrepoimp.dart';
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';
import 'package:mkr/features/clients/clientmoves/data/repos/clientmoverepoimp.dart';
import 'package:mkr/features/clients/clientmoves/presentation/viewmodel/cubit/clientmoves_cubit.dart';
import 'package:mkr/features/componentstore/data/repos/componentrepoimp.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';
import 'package:mkr/features/fullprodstore/data/repos/fullprodtrpoimp.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:mkr/features/home/presentation/view/home2.dart';
import 'package:mkr/features/suppliers/supplier/data/repos/supplierrepoimp.dart';
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/repos/suppliermoverepoimp.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/viewmodel/supplier/suppliermoves_cubit.dart';
import 'package:mkr/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:mkr/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:mkr/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Apiservice.initdio();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: DefaultSelectionStyle.defaultColor));
  await cashhelper.initcashhelper();
  runApp(EasyLocalization(
      path: "assets/translations",
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      saveLocale: true,
      startLocale: Locale("ar"),
      fallbackLocale: const Locale("ar"),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(Authrepoimp()),
          ),
          BlocProvider(
            create: (context) => ClientmovesCubit(Clientmoverepoimp()),
          ),
          BlocProvider(
            create: (context) =>
                AddemployeeCubit(addemployeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) =>
                showemployeescuibt(employeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) => suppliermovesCubit(suppliermoverepoimp()),
          ),
          BlocProvider(
            create: (context) => fullprodCubit(fullprodrepoimp()),
          ),
          BlocProvider(
            create: (context) => ClientCubit(Clientrepoimp()),
          ),
          BlocProvider(
            create: (context) => supplierCubit(supplierrepoimp()),
          ),
          BlocProvider(
            create: (context) => ComponentCubit(Componentrepoimp()),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return GetMaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: child,
              );
            },
            child:
                cashhelper.getdata(key: "token") == null ? Login() : home2()));
  }
}
