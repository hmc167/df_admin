import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trina_grid/trina_grid.dart';

import '../controllers/reportorder_controller.dart';
import '../utils/colors.dart';
import '../utils/helpers.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class ReportOrderView extends StatefulWidget {
  const ReportOrderView({super.key});

  @override
  State<ReportOrderView> createState() => _ReportOrderViewState();
}

class _ReportOrderViewState extends State<ReportOrderView> {
  final ReportOrderController controller = Get.put(ReportOrderController());
  late TrinaGridStateManager stateManager;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                spacing: 10,
                children: [
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterClusterId.value,
                      hint: Text('Cluster'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Text('Cluster (Delivery Hub)'),
                        ),
                        ...List.generate(controller.clusters.length, (index) {
                          var cluster = controller.clusters[index];
                          return DropdownMenuItem(
                            value: cluster.iD,
                            child: Text(cluster.name ?? ''),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        controller.filterClusterId.value = value ?? 1;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.filterNameController,
                      decoration: InputDecoration(
                        labelText: 'Customer Name, Mobile or Invoice Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: controller.filterStartDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Start Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  controller.filterStartDate.value ??
                                  DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              controller.filterStartDate.value = picked;
                              controller.filterStartDateController.text =
                                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: controller.filterEndDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'End Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  controller.filterEndDate.value ??
                                  DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              controller.filterEndDate.value = picked;
                              controller.filterEndDateController.text =
                                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterStatus.value,
                      hint: Text('Order Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Text('Order Status'),
                        ),
                        DropdownMenuItem(value: -1, child: Text('All')),
                        DropdownMenuItem(value: 0, child: Text('New')),
                        DropdownMenuItem(value: 1, child: Text('Confirmed')),
                        DropdownMenuItem(value: 2, child: Text('ReadyToShip')),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('OutForDelivery'),
                        ),
                        DropdownMenuItem(value: 4, child: Text('Delivered')),
                        DropdownMenuItem(value: 5, child: Text('Cancelled')),
                        //DropdownMenuItem(value: 6, child: Text('Returned')),
                      ],
                      onChanged: (value) {
                        controller.filterStatus.value = value ?? 0;
                      },
                    ),
                  ),
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterPaymentStatus.value,
                      hint: Text('Payment Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Text('Payment Status'),
                        ),
                        DropdownMenuItem(value: -1, child: Text('All')),
                        DropdownMenuItem(value: 0, child: Text('Pending')),
                        DropdownMenuItem(value: 1, child: Text('Paid')),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('PartiallyPaid'),
                        ),
                        DropdownMenuItem(value: 3, child: Text('Failed')),
                        DropdownMenuItem(value: 4, child: Text('Cancelled')),
                        //DropdownMenuItem(value: 5, child: Text('Refunded')),
                      ],
                      onChanged: (value) {
                        controller.filterPaymentStatus.value = value ?? 0;
                      },
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Switch(
                          value: controller.filterOnlyLock.value,
                          onChanged: (value) {
                            controller.filterOnlyLock.value = value;
                          },
                        ),
                        Text('Locked'),
                      ],
                    ),
                  ),
                  CommonButton(
                    width: 140,
                    text: 'Generate',
                    icon: Icons.search,
                    onTap: () async {
                      Get.showOverlay(
                        asyncFunction: () async {
                          await controller.search();
                        },
                        loadingWidget: Helpers.loadingWidget(),
                      );
                    },
                  ),
                  CommonButton(
                    width: 110,
                    text: 'Reset',
                    icon: Icons.refresh,
                    color: AppColors.backgroundColor,
                    textColor: AppColors.primaryColor,
                    onTap: () async {
                      // Reset search filters

                      Get.showOverlay(
                        asyncFunction: () async {
                          await controller.resetSearchFilters();
                        },
                        loadingWidget: Helpers.loadingWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Obx(
                () => TrinaGrid(
                  columns: [
                    TrinaColumn(
                      title: '#',
                      field: 'id',
                      type: TrinaColumnType.text(),
                      width: 60,
                      frozen: TrinaColumnFrozen.start,
                    ),
                    TrinaColumn(
                      title: 'Name',
                      field: 'name',
                      type: TrinaColumnType.text(),
                      frozen: TrinaColumnFrozen.start,
                    ),
                    TrinaColumn(
                      title: 'Delivery Slot',
                      field: 'delivery_slot',
                      type: TrinaColumnType.text(),
                      width: 250,
                    ),
                    TrinaColumn(
                      title: 'Invoice Number',
                      field: 'invoice_number',
                      type: TrinaColumnType.text(),
                    ),
                    TrinaColumn(
                      title: 'Qty',
                      field: 'qty',
                      type: TrinaColumnType.number(),
                    ),
                    TrinaColumn(
                      title: 'Status',
                      field: 'status',
                      type: TrinaColumnType.text(),
                    ),
                    TrinaColumn(
                      title: 'Amount',
                      field: 'amount',
                      type: TrinaColumnType.number(format: '₹ #,##0.00'),
                    ),
                  ],
                  rows: controller.orders
                      .map(
                        (order) => TrinaRow(
                          cells: {
                            'id': TrinaCell(
                              value: controller.orders.indexOf(order) + 1,
                            ),
                            'name': TrinaCell(value: order.customerName ?? ''),
                            'delivery_slot': TrinaCell(
                              value: order.deliverySlot ?? '',
                            ),
                            'invoice_number': TrinaCell(
                              value: order.invoiceNumber ?? '',
                            ),
                            'qty': TrinaCell(value: order.qty ?? 0),
                            'status': TrinaCell(
                              value: controller.getOrderStatusText(
                                order.orderStatus ?? 0,
                              ),
                            ),
                            'amount': TrinaCell(
                              value: order.totalAmount ?? 0.0,
                            ),
                          },
                        ),
                      )
                      .toList(),
                  onLoaded: (TrinaGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                  },
                  onChanged: (TrinaGridOnChangedEvent event) {
                    print(event);
                  },

                  configuration: const TrinaGridConfiguration(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  Obx(
                    () => Text(
                      'Total Orders: ${controller.orders.length}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                 // Spacer(),
                  IconButton(
                    onPressed: controller.exportCsv,
                    icon: const Icon(Icons.download),
                  ),
                  IconButton(
                    onPressed: controller.exportPdf,
                    icon: const Icon(Icons.picture_as_pdf, color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
