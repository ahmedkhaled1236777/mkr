import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as ll;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../workers/data/models/workermodel/datum.dart';

class Attendancepdf {
  static Future<File> generatepdf({
    required Uint8List imageBytes,
    required String date,
    required ll.BuildContext context,
    required List<Datum> categories,
  }) async {
    final pdf = pw.Document();
    final theme = pw.ThemeData.withFont(
      base: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
      bold: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
    );
    final data = categories.map((item) {
      return [
        BlocProvider.of<Attendancecuibt>(context).getsalary(item),
        item.totalExtraTime,
        item.totalPermissions,
        item.totalVacation,
        item.totalAbsence,
        item.totalAttendance,
        item.name,
      ];
    }).toList();
    //دائن

    //مدين

    pdf.addPage(pw.MultiPage(
      theme: theme,
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(12),
      textDirection: TextDirection.rtl,
      build: (context) => [
        pw.Container(
          alignment: pw.Alignment.center,
          height: 100,
          child: pw.Image(pw.MemoryImage(imageBytes)),
        ),
        pw.SizedBox(height: 10),
        buildbasic(
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"),
        pw.SizedBox(height: 10),
        pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text("الحضور والانصراف لشهر ${date}",
                      style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.blue900,
                          fontBold: pw.Font.courier())),
                ])),
        pw.Table.fromTextArray(
            headerDecoration: pw.BoxDecoration(color: PdfColors.blue900),
            headerHeight: 10,
            cellHeight: 10,
            columnWidths: {
              0: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              1: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              2: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              3: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
            },
            cellAlignment: pw.Alignment.center,
            headerAlignment: pw.Alignment.center,
            headerAlignments: {
              0: pw.Alignment.center,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
              3: pw.Alignment.center,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontBold: pw.Font.courierBold(),
                fontSize: 14),
            headers: [
              "الراتب",
              "ساعات الاضافى",
              "ساعات الاذن",
              "ايام الاجازه",
              "ايام الغياب",
              "ايام الحضور",
              "اسم الموظف",
            ],
            data: data),
      ],
    ));

    return await savepdf("الحضور والانصراف", pdf);
  }

  static Future<File> savepdf(String filename, pw.Document pdf) async {
    final bytes = await pdf.save();
    // var dir = await getApplicationDocumentsDirectory();
    var dir = await getExternalStorageDirectory();
    final file = File(
        '${dir!.path}/$filename${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openfile(File file) async {
    final url = file.path;
    return await OpenFile.open(url);
  }

  static buildbasic(String date) {
    return pw.Row(children: [
      pw.Text("الحضور والانصراف",
          style: pw.TextStyle(
              decoration: pw.TextDecoration.underline, fontSize: 17)),
      pw.Spacer(),
      pw.Text(date,
          style: pw.TextStyle(
              decoration: pw.TextDecoration.underline, fontSize: 17))
    ]);
  }
}
