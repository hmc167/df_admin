import 'dart:io';

import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as h2p;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/report_order_estimate.dart';
import '../services/api_service_report.dart';

class ReportDailyOrderProductController extends GetxController {
  var isLoading = false.obs;
  final filterOrderDateController = TextEditingController();

  final onlyItemDetails = false.obs;
  Rxn<DateTime> filterOrderDate = Rxn<DateTime>();
  RxList<OrderEstimate> orderEstimates = <OrderEstimate>[].obs;

  var reportString = ''.obs;
  int pageCharCount = 42;
  void updateReportString() {
    if (orderEstimates.isEmpty) {
      reportString.value = 'No data available for the selected date.';
      return;
    }
    final buffer = StringBuffer();
    buffer.writeln('\n');
    buffer.writeln(_repeatChar('=', pageCharCount));
    buffer.writeln(_centerText('Order Estimate Report', pageCharCount));
    buffer.writeln(
      _centerText('(${filterOrderDateController.text})', pageCharCount),
    );
    buffer.writeln(_repeatChar('=', pageCharCount) + '\n');
    buffer.writeln(
      _leftText('#', 3)! + _leftText('Item Name', 30)! + _rightText('Total', 9),
    );
    buffer.writeln(_repeatChar('-', pageCharCount));
    int index = 1;
    for (var estimate in orderEstimates) {
      buffer.writeln(
        _leftText(index.toString(), 3)! +
            _leftText('${estimate.name}', 30)! +
            _rightText('${estimate.total}', 9),
      );
      if (!onlyItemDetails.value) continue;
      if (estimate.orderItemEstimates != null) {
        for (var item in estimate.orderItemEstimates!) {
          buffer.writeln(
            '${_leftText('', 3)}${_leftText('Qty:${item.qty} * ${item.unitName}', 25)!}=${_rightText('${item.unitTotal}', 8)}',
          );
        }
      }
      buffer.writeln('\n');
      index++;
    }

    buffer.writeln('\n');
    buffer.writeln(_centerText('-- End Of Report --', pageCharCount));
    buffer.writeln('\n');
    buffer.writeln('\n');
    buffer.writeln('\n');
    reportString.value = buffer.toString();
  }

  @override
  void onInit() {
    super.onInit();
    filterOrderDate.value = DateTime.now();
    filterOrderDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
  }

  void generate() async {
    await fetchReportData();
  }

  void resetSearchFilters() {
    onlyItemDetails.value = false;
    filterOrderDate.value = DateTime.now();
    filterOrderDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";

    fetchReportData();
  }

  Future<void> fetchReportData() async {
    isLoading.value = true;
    final result = await ApiServiceReport.orderEstimate(
      DateTime(
        filterOrderDate.value?.year ?? 2025,
        filterOrderDate.value?.month ?? 1,
        filterOrderDate.value?.day ?? 1,
        0,
        0,
        0,
      ),
      onlyItemDetails.value,
    );
    if (result.hasError == false) {
      reportString.value = result.data?.reportString ?? '';
      orderEstimates.value = result.data?.records ?? [];
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching report data',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      orderEstimates.value = [];
      reportString.value = '';
    }
    //updateReportString();
    isLoading.value = false;
  }

  String? _centerText(String s, int i) {
    if (s.length > i) {
      // If string is longer than the width, break into new lines
      final buffer = StringBuffer();
      int start = 0;
      while (start < s.length) {
        int end = (start + i < s.length) ? start + i : s.length;
        buffer.writeln(_centerText(s.substring(start, end), i));
        start += i;
      }
      return buffer.toString().trimRight();
    }
    if (s.length == i) return s;
    int leftPadding = ((i - s.length) / 2).floor();
    int rightPadding = i - s.length - leftPadding;
    return ' ' * leftPadding + s + ' ' * rightPadding;
  }

  _repeatChar(String s, int pageCharCount) {
    return s * pageCharCount;
  }

  String? _leftText(String s, int i) {
    if (s.length > i) {
      // Break into new lines if string is longer than the width
      final buffer = StringBuffer();
      int start = 0;
      while (start < s.length) {
        int end = (start + i < s.length) ? start + i : s.length;
        buffer.writeln(_leftText(s.substring(start, end), i));
        start += i;
      }
      return buffer.toString().trimRight();
    }
    if (s.length == i) return s;
    int rightPadding = i - s.length;
    return s + ' ' * rightPadding;
  }

  String _rightText(String s, int i) {
    if (s.length > i) {
      // Break into new lines if string is longer than the width
      final buffer = StringBuffer();
      int start = 0;
      while (start < s.length) {
        int end = (start + i < s.length) ? start + i : s.length;
        buffer.writeln(_rightText(s.substring(start, end), i));
        start += i;
      }
      return buffer.toString().trimRight();
    }
    if (s.length == i) return s;
    int leftPadding = i - s.length;
    return ' ' * leftPadding + s;
  }

  Future<File> savePdf(String filename) async {
    List<int> bytes = await htmlToPdfBytes(reportString.value);
    final dir =
        await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    await OpenFilex.open(file.path);
    return file;
  }

  Future<List<int>> htmlToPdfBytes(String html) async {
    final latin = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans/NotoSans-Regular.ttf'),
    );
    final latinBold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans/NotoSans-Bold.ttf'),
    );
    final guj = pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/NotoSansGujarati/NotoSansGujarati-Regular.ttf',
      ),
    );
    final gujBold = pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/NotoSansGujarati/NotoSansGujarati-Bold.ttf',
      ),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: latin, bold: latinBold),
    );

    final widgets = await h2p.HTMLToPdf().convert(html);

    doc.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.DefaultTextStyle(
            style: pw.TextStyle(fontFallback: [guj, gujBold]),
            child: pw.Column(children: widgets),
          ),
        ],
      ),
    );

    return doc.save();
  }
}
