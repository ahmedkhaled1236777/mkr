import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/date/date_cubit.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/choosedate.dart';
import 'package:mkr/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:mkr/core/common/widgets/customtextform.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/errorwidget.dart';
import 'package:mkr/features/componentstore/presentation/viewmodel/componentcuibt/component_cubit.dart';
import 'package:mkr/features/suppliers/supplier/presentation/viewmodel/supplier/supplier_cubit.dart';
import 'package:mkr/features/suppliers/suppliermoves/data/models/suppliermoverequest.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/view/widgets/radios.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';
import 'package:mkr/features/suppliers/suppliermoves/presentation/viewmodel/supplier/suppliermoves_cubit.dart';

class addsuppliermove extends StatefulWidget {
  final String suppliername;
  final int supplierid;

  addsuppliermove({
    super.key,
    required this.supplierid,
    required this.suppliername,
  });
  @override
  State<addsuppliermove> createState() => _addsuppliermoveState();
}

class _addsuppliermoveState extends State<addsuppliermove> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController price = TextEditingController();
  TextEditingController discount_perc = TextEditingController();
  TextEditingController qty = TextEditingController();

  TextEditingController notes = TextEditingController();
  @override
  void initState() {
    if (BlocProvider.of<ComponentCubit>(context).products.isEmpty)
      BlocProvider.of<ComponentCubit>(context).getcomponents();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                " اضافة حركة للمورد ${widget.suppliername}",
                style: Styles.appbarstyle,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/home.png",
                      ))),
              child: Center(
                child: Form(
                    key: formkey,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 9),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            const SizedBox(
                              height: 25,
                            ),
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                return suppliermovesradio(
                                  firstradio: "0",
                                  secondradio: "1",
                                  firstradiotitle: "توريد",
                                  secondradiotitle: "دفع",
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                if (state is getcomponentloading)
                                  return loading();
                                if (state is getcomponentfailure)
                                  return Text(state.errormessage);
                                return Column(children: [
                                  if (BlocProvider.of<ComponentCubit>(context)
                                          .type ==
                                      "0")
                                    Container(
                                      color: Color(0xff535C91),
                                      child: Center(
                                        child: BlocBuilder<suppliermovesCubit,
                                            suppliermovesState>(
                                          builder: (context, state) {
                                            return DropdownSearch<String>(
                                              dropdownButtonProps:
                                                  DropdownButtonProps(
                                                      color: Colors.white),
                                              popupProps: PopupProps.menu(
                                                  showSelectedItems: true,
                                                  showSearchBox: true,
                                                  searchFieldProps:
                                                      TextFieldProps()),
                                              selectedItem: BlocProvider.of<
                                                      ComponentCubit>(context)
                                                  .productname,
                                              items: BlocProvider.of<
                                                      ComponentCubit>(context)
                                                  .products,
                                              onChanged: (value) {
                                                BlocProvider.of<ComponentCubit>(
                                                        context)
                                                    .changeproduct(value!);
                                              },
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                      baseStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "cairo"),
                                                      textAlign:
                                                          TextAlign.center,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        enabled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff535C91)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff535C91)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ]);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<ComponentCubit, ComponentState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    if (BlocProvider.of<ComponentCubit>(context)
                                            .type ==
                                        "0")
                                      custommytextform(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9-.]")),
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: qty,
                                        hintText:
                                            "الكميه ب${BlocProvider.of<ComponentCubit>(context).productpacktype[BlocProvider.of<ComponentCubit>(context).productname] ?? ""}",
                                        val: "برجاء ادخال الكميه",
                                      ),
                                    if (BlocProvider.of<ComponentCubit>(context)
                                            .type ==
                                        "0")
                                      SizedBox(height: 10),
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: price,
                                      hintText: BlocProvider.of<ComponentCubit>(
                                                      context)
                                                  .type ==
                                              "1"
                                          ? "المبلغ المدفوع"
                                          : "سعر القطعه",
                                      val: BlocProvider.of<ComponentCubit>(
                                                      context)
                                                  .type ==
                                              "1"
                                          ? "برجاء ادخال المبلغ المدفوع"
                                          : "برجاء ادخال سعر القطعه",
                                    ),
                                    SizedBox(height: 10),
                                    custommytextform(
                                      controller: notes,
                                      hintText: "الملاحظات",
                                      val: "برجاء ادخال الملاحظات",
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              },
                            ),
                            BlocConsumer<suppliermovesCubit,
                                suppliermovesState>(
                              listener: (context, state) async {
                                if (state is addsuppliermovefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addsuppliermovesuccess) {
                                  qty.clear();
                                  price.clear();
                                  notes.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<ComponentCubit>(context)
                                      .resetprodname();

                                  await BlocProvider.of<suppliermovesCubit>(
                                          context)
                                      .getsuppliermoves(
                                          clienid: widget.supplierid);
                                  await BlocProvider.of<supplierCubit>(context)
                                      .getsuppliers();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addsuppliermoveloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (BlocProvider.of<ComponentCubit>(context)
                                            .type ==
                                        "0") {
                                      if (BlocProvider.of<ComponentCubit>(
                                                  context)
                                              .productname ==
                                          "اختر المنتج") {
                                        showdialogerror(
                                            error: "لابد من اختيار المنتج",
                                            context: context);
                                      } else if (price.text.isEmpty ||
                                          qty.text.isEmpty ||
                                          notes.text.isEmpty) {
                                        showdialogerror(
                                            error: "لابد من مليء جميع الحقول",
                                            context: context);
                                      } else {
                                        BlocProvider.of<suppliermovesCubit>(context).addsuppliermovemove(
                                            suppliermove: suppliermoverequest(
                                                componentid: BlocProvider.of<
                                                        ComponentCubit>(context)
                                                    .productid[BlocProvider.of<
                                                        ComponentCubit>(context)
                                                    .productname],
                                                supplierid: widget.supplierid,
                                                date:
                                                    BlocProvider.of<DateCubit>(context)
                                                        .date1,
                                                qty: qty.text,
                                                price: price.text,
                                                notes: notes.text,
                                                status:
                                                    BlocProvider.of<ComponentCubit>(context)
                                                        .type));
                                      }
                                    } else {
                                      if (notes.text.isEmpty ||
                                          price.text.isEmpty) {
                                        showdialogerror(
                                            error: "لابد من ملىء جميع الحقول",
                                            context: context);
                                      } else {
                                        BlocProvider.of<suppliermovesCubit>(
                                                context)
                                            .addsuppliermovemove(
                                                suppliermove: suppliermoverequest(
                                                    supplierid:
                                                        widget.supplierid,
                                                    date: BlocProvider.of<
                                                            DateCubit>(context)
                                                        .date1,
                                                    qty: null,
                                                    price: price.text,
                                                    notes: notes.text,
                                                    status: BlocProvider.of<
                                                                ComponentCubit>(
                                                            context)
                                                        .type));
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
