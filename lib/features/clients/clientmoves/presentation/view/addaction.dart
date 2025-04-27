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
import 'package:mkr/features/clients/clieents/presentation/viewmodel/client/client_cubit.dart';
import 'package:mkr/features/clients/clientmoves/data/models/clientmoverequest.dart';
import 'package:mkr/features/clients/clientmoves/presentation/view/widgets/radios.dart';
import 'package:mkr/features/clients/clientmoves/presentation/viewmodel/cubit/clientmoves_cubit.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mkr/features/fullprodstore/presentation/viewmodel/fullprodcuibt/fullprod_state.dart';

class addclientmove extends StatefulWidget {
  final String clientname;
  final int clientid;

  addclientmove({
    super.key,
    required this.clientid,
    required this.clientname,
  });
  @override
  State<addclientmove> createState() => _addclientmoveState();
}

class _addclientmoveState extends State<addclientmove> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController price = TextEditingController();
  TextEditingController discount_perc = TextEditingController();
  TextEditingController qty = TextEditingController();

  TextEditingController notes = TextEditingController();
  @override
  void initState() {
    if (BlocProvider.of<fullprodCubit>(context).products.isEmpty)
      BlocProvider.of<fullprodCubit>(context).getfullprods();
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
                " اضافة حركة للعميل ${widget.clientname}",
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
                            BlocBuilder<fullprodCubit, fullprodState>(
                              builder: (context, state) {
                                return movesradio(
                                  thirdradio: "2",
                                  firstradio: "0",
                                  secondradio: "1",
                                  firstradiotitle: "عمليه",
                                  secondradiotitle: "دفع",
                                  thirdradiotittle: "مرتجع",
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
                            BlocBuilder<fullprodCubit, fullprodState>(
                              builder: (context, state) {
                                if (state is getfullprodloading)
                                  return loading();
                                if (state is getfullprodfailure)
                                  return Text(state.errormessage);
                                return Column(children: [
                                  if (BlocProvider.of<fullprodCubit>(context)
                                          .type !=
                                      "1")
                                    Container(
                                      color: Color(0xff535C91),
                                      child: Center(
                                        child: BlocBuilder<ClientmovesCubit,
                                            ClientmovesState>(
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
                                                      fullprodCubit>(context)
                                                  .productname,
                                              items: BlocProvider.of<
                                                      fullprodCubit>(context)
                                                  .products,
                                              onChanged: (value) {
                                                BlocProvider.of<fullprodCubit>(
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
                            BlocBuilder<fullprodCubit, fullprodState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    if (BlocProvider.of<fullprodCubit>(context)
                                            .type !=
                                        "1")
                                      custommytextform(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9-.]")),
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: qty,
                                        hintText:
                                            "الكميه ب${BlocProvider.of<fullprodCubit>(context).productpacktype[BlocProvider.of<fullprodCubit>(context).productname] ?? ""}",
                                        val: "برجاء ادخال الكميه",
                                      ),
                                    if (BlocProvider.of<fullprodCubit>(context)
                                            .type !=
                                        "1")
                                      SizedBox(height: 10),
                                    if (BlocProvider.of<fullprodCubit>(context)
                                            .type !=
                                        "1")
                                      custommytextform(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9-.]")),
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: discount_perc,
                                        hintText: "نسبة الخصم %",
                                        val: "برجاء ادخال نسبة الخصم",
                                      ),
                                    SizedBox(height: 10),
                                    if (BlocProvider.of<fullprodCubit>(context)
                                            .type ==
                                        "1")
                                      custommytextform(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[0-9-.]")),
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: price,
                                        hintText: "المبلغ المدفوع",
                                        val: "برجاء ادخال المبلغ المدفوع",
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
                            BlocConsumer<ClientmovesCubit, ClientmovesState>(
                              listener: (context, state) async {
                                if (state is addclientmovefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addclientmovesuccess) {
                                  qty.clear();
                                  discount_perc.clear();
                                  price.clear();
                                  notes.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<fullprodCubit>(context)
                                      .resetprodname();

                                  await BlocProvider.of<ClientmovesCubit>(
                                          context)
                                      .getclientmoves(clienid: widget.clientid);
                                  await BlocProvider.of<ClientCubit>(context)
                                      .getclients();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addclientmoveloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (BlocProvider.of<fullprodCubit>(context)
                                            .type !=
                                        "1") {
                                      if (BlocProvider.of<fullprodCubit>(
                                                  context)
                                              .productname ==
                                          "اختر المنتج") {
                                        showdialogerror(
                                            error: "لابد من اختيار المنتج",
                                            context: context);
                                      } else if (discount_perc.text.isEmpty ||
                                          qty.text.isEmpty ||
                                          notes.text.isEmpty) {
                                        showdialogerror(
                                            error: "لابد من مليء جميع الحقول",
                                            context: context);
                                      } else {
                                        BlocProvider.of<ClientmovesCubit>(context).addclientmovemove(
                                            clientmove: Clientmoverequest(
                                                fullprodid: BlocProvider.of<
                                                        fullprodCubit>(context)
                                                    .productid[BlocProvider.of<
                                                        fullprodCubit>(context)
                                                    .productname],
                                                clientid: widget.clientid,
                                                date: BlocProvider.of<DateCubit>(context)
                                                    .date1,
                                                qty: qty.text,
                                                price: null,
                                                discount_percentage:
                                                    discount_perc.text,
                                                notes: notes.text,
                                                status: BlocProvider.of<fullprodCubit>(context)
                                                    .type));
                                      }
                                    } else {
                                      if (notes.text.isEmpty ||
                                          price.text.isEmpty) {
                                        showdialogerror(
                                            error: "لابد من ملىء جميع الحقول",
                                            context: context);
                                      } else {
                                        BlocProvider.of<ClientmovesCubit>(
                                                context)
                                            .addclientmovemove(
                                                clientmove: Clientmoverequest(
                                                    clientid: widget.clientid,
                                                    date: BlocProvider.of<
                                                            DateCubit>(context)
                                                        .date1,
                                                    qty: null,
                                                    price: double.tryParse(
                                                            price.text)
                                                        .toString(),
                                                    discount_percentage: null,
                                                    notes: notes.text,
                                                    status: BlocProvider.of<
                                                                fullprodCubit>(
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
