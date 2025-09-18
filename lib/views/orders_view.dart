import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final OrdersController controller = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is Map && args['islocked'] != null) {
      controller.filterOnlyLock.value = args['islocked'] as bool;
    } else if (args != null && args is Map && args['search'] != null) {
      controller.filterNameController.text = args['search'] as String;
    } 
    controller.search();
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
                spacing: 20,
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
                        width: 160,
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
                        width: 160,
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
                    width: 110,
                    text: 'Search',
                    icon: Icons.search,
                    onTap: () async {
                      controller.search();
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
                      controller.resetSearchFilters();
                    },
                  ),
                  SizedBox(width: 20),
                  CommonButton(
                    width: 110,
                    text: 'New',
                    icon: Icons.add,
                    onTap: () async {
                      await controller.openAddPopup(0);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Delivery Slot',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Invoice Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Qty',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Payment Status',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(
                    width: 100,
                    child: Text(
                      'IsLocked',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: Obx(
                () => ListView(
                  children: [
                    ...List.generate(controller.orders.length, (index) {
                      var order = controller.orders[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColors.textColorWhite
                              : AppColors.borderColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 40, child: Text('${index + 1}')),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  order.customerName ?? '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                order.deliverySlot ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                order.invoiceNumber ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                order.qty?.toString() ?? '0',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                controller.getOrderStatusText(order.orderStatus),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            SizedBox(
                              width: 150,
                              child: Text(
                                controller.getPaymentStatusText(order.paymentStatus),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  //
                                },
                                child: SizedBox(
                                  width: 100,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: order.isLock == true
                                        ? Icon(
                                            Icons.check_circle,
                                            color: AppColors.successColor,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: AppColors.errorColor,
                                            size: 20,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            
                            SizedBox(
                              width: 100,
                              child: Text(
                                order.totalAmount?.toStringAsFixed(2) ?? '0.00',
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(!(((order.orderStatus??0) > 3) || (order.isLock == false)))
                                  InkWell(
                                    onTap: () async {
                                        await controller.changeStatus(
                                          order,
                                        );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.change_circle,
                                        size: 20,
                                        color: AppColors.warningColor,
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      await controller.openAddPopup(order.id ?? 0);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 20,
                                        color: AppColors.infoColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (controller.orders.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textColorWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'No records found',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      'Total Orders: ${controller.orders.length}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Obx(
                    () => CommonButton(
                      width: 240,
                      text: controller.isLockingOrder.value ? 'Locking...' : 'Lock All Orders',
                      icon: Icons.lock,
                      onTap: controller.isLockingOrder.value
                          ? () {}
                          : () async {
                              await controller.lockAllOrders();
                            },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
