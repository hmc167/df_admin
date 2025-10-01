import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/cluster_master.dart';
import '../models/customer_model.dart';
import '../models/delivery_slots.dart';
import '../models/order.dart';
import '../services/api_service_customer_master.dart';
import '../services/api_service_report.dart';

class ReportOrderController extends GetxController {
  RxBool isLockingOrder = false.obs;
   RxBool isCancellingOrder = false.obs;
   RxBool isNotifyingLockOrder = false.obs;
  var isLoading = false.obs;

  
  final filterNameController = TextEditingController();
  final filterStartDateController = TextEditingController();
  final filterEndDateController = TextEditingController();
  final customerSearchController = TextEditingController();
  
  final filterOnlyLock = false.obs;
  final filterCategoryId = 0.obs;
  final RxInt filterStatus = (-1).obs;
  final RxInt filterPaymentStatus = (-1).obs;
  final filterCustomerId = 0.obs;
  final RxnInt filterClusterId = RxnInt();
  Rxn<DateTime> filterStartDate = Rxn<DateTime>();
  Rxn<DateTime> filterEndDate = Rxn<DateTime>();

  final nameFocusNode = FocusNode();
  RxList<ClusterMaster> clusters = <ClusterMaster>[].obs;
  RxList<CustomerInfo> customers = <CustomerInfo>[].obs;  
  RxList<Order> orders = <Order>[].obs;
  RxList<DeliverySlots> deliverySlots = <DeliverySlots>[].obs;
  Rxn<OrderDetailData> selectedOrder = Rxn<OrderDetailData>();
  
  final RxInt selectedProduct = 0.obs;
  final RxInt selectedVariant = 0.obs;
  @override
  void onInit() {
    super.onInit();
    bindClusters();
    filterStartDate.value = DateTime.now();
    filterStartDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    filterEndDate.value = DateTime.now();
    filterEndDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  Future<void> search() async {
    await getOrders();
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    filterOnlyLock.value = false;
    filterStatus.value = -1;
    filterPaymentStatus.value = -1;
    filterCustomerId.value = 0;
    customers.clear();
    filterStartDate.value = DateTime.now();
    filterStartDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    filterEndDate.value = DateTime.now();
    filterEndDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    await getOrders();
  }

  Future<void> bindClusters() async {
    var result = await ApiServiceCustomerMaster.allClusterMasters();
    if (result.hasError == false) {
      clusters.value = result.data?.records ?? [];
      filterClusterId.value = clusters.firstOrNull?.iD ?? 1;      
    } else {
      clusters.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching clusters',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getOrders() async {
    final result = await ApiServiceReport.allOrders(
      DateTime(
        filterStartDate.value?.year ?? 2025,
        filterStartDate.value?.month ?? 1,
        filterStartDate.value?.day ?? 1,
        0,
        0,
        0,
      ),
      DateTime(
        filterEndDate.value?.year ?? 2025,
        filterEndDate.value?.month ?? 1,
        filterEndDate.value?.day ?? 1,
        23,
        59,
        59,
      ),
      orderStatus: (filterStatus.value > -1) ? filterStatus.value : null,
      paymentStatus: (filterPaymentStatus.value > -1)
          ? filterPaymentStatus.value
          : null,
      customerId: (filterCustomerId.value > 0) ? filterCustomerId.value : null,
      clusterMasterId: filterClusterId.value??1,
      isLocked: filterOnlyLock.value ? true : null,
      searchString: filterNameController.text.trim(),
    );
    if (result.hasError == false) {
      var dbOrders = result.data?.records ?? [];
      if (dbOrders.isNotEmpty) {
        orders.value = dbOrders;
      }
      else{
        orders.value = [];
      }
    } else {
      orders.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching orders',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<List<CustomerInfo>> fetchCustomers(String text) async {
    if (text.isEmpty) {
      return [];
    }
    final result = await ApiServiceCustomerMaster.search(text);
    if (result.hasError == false) {
      return result.data?.records ?? [];
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching customers',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      return [];
    }
  }

  String getOrderStatusText(int? orderStatus) {
    switch (orderStatus) {
      case 0:
        return 'Pending (New)';
      case 1:
        return 'Confirmed';
      case 2:
        return 'ReadyToShip';
      case 3:
        return 'OutForDelivery';
      case 4:
        return 'Delivered';
      case 5:
        return 'Cancelled';
      case 6:
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  String getPaymentStatusText(int? paymentStatus) {
    switch (paymentStatus) {
      case 0:
        return 'Pending';
      case 1:
        return 'Paid';
      case 2:
        return 'PartiallyPaid';
      case 3:
        return 'Failed';
      case 4:
        return 'Cancelled';
      case 5:
        return 'Refunded';
      default:
        return 'Unknown';
    }
  }

  Future<void> exportCsv() async {
    
    if (orders.isEmpty) {
      Get.snackbar('Export', 'No orders to export');
      return;
    }
    final rows = <List<dynamic>>[];
    rows.add(['ID', 'Customer', 'Notes','Date', 'Total', 'Status']);
    for (final o in orders) {
      rows.add([o.id, o.customerName, o.notes ?? '', o.createdDate??'', o.totalAmount?.toStringAsFixed(2), getOrderStatusText(o.orderStatus)]);
    }
    final csvStr = const ListToCsvConverter().convert(rows);

    // Ask user for filename & save
     final dir =
        await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${DateTime.now().millisecondsSinceEpoch}_orders_report.csv');
    await file.writeAsString(csvStr);
    Get.snackbar('Export', 'CSV saved to ${file.path}');
  }

  Future<void> exportPdf() async {
    
    if (orders.isEmpty) {
      Get.snackbar('Export', 'No orders to export');
      return;
    }

    final doc = pw.Document();
    final headers = ['#', 'Customer', 'Notes', 'Date', 'Total', 'Status'];
    final data = orders.asMap().entries.map((entry) => [
      entry.key+1,
      entry.value.customerName,
      entry.value.notes ?? '',
      entry.value.createdDate ?? '',
      entry.value.totalAmount?.toStringAsFixed(2),
      getOrderStatusText(entry.value.orderStatus)
    ]).toList();

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
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Order Report',),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: data,
            cellStyle:pw.TextStyle(fontFallback: [guj, gujBold]),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontFallback: [guj, gujBold]),
          ),
        ],
      ),
    );

    // Show print preview and allow save/print
    await Printing.layoutPdf(
      onLayout: (format) => doc.save(),
      usePrinterSettings: true,
      dynamicLayout: false,
      format: PdfPageFormat.a4,
      name: '${DateTime.now().millisecondsSinceEpoch}_orders_report.pdf',
    );
  }
   

}

