import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../models/customer_model.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is Map && args['approved'] != null) {
      controller.filterApproved.value = args['approved'] as int;
      controller.searchCustomers();
    }
    else if (args != null && args is Map && args['todayonly'] != null) {
      controller.filterTodayOnly.value = args['todayonly'] as bool;
      controller.searchCustomers();
    }
    else if (args != null && args is Map && args['search'] != null) {
      controller.filterNameController.text = args['search'] as String;
      controller.searchCustomers();
    }
    else{
      controller.loadData();
    }
  }
  final CustomersController controller = Get.put(CustomersController());
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
              'Customers',
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
                  Expanded(
                    child: TextField(
                      controller: controller.filterNameController,
                      decoration: InputDecoration(
                        labelText: 'Name Or Mobile',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterStatus.value,
                      hint: Text('Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(value: null, enabled: false, child: Text('Status'),),
                        DropdownMenuItem(value: 0, child: Text('All')),
                        DropdownMenuItem(value: 1, child: Text('Active')),
                        DropdownMenuItem(value: 2, child: Text('Inactive')),
                      ],
                      onChanged: (value) {
                        controller.filterStatus.value = value ?? 0;
                      },
                    ),
                  ),
                  Obx(
                    () => DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: controller.filterApproved.value,
                      hint: Text('Approved'),                      
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(value: null,  enabled: false,  child: Text('Approved Status')),
                        DropdownMenuItem(value: 0, child: Text('All')),
                        DropdownMenuItem(value: 1, child: Text('Approved')),
                        DropdownMenuItem(value: 2, child: Text('Pending')),
                      ],
                      onChanged: (value) {
                        controller.filterApproved.value = value ?? 0;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Obx(
                    () => Row(
                      children: [
                        Switch(
                          value: controller.filterTodayOnly.value,
                          onChanged: (value) {
                            controller.filterTodayOnly.value = value;
                          },
                        ),
                        Text('Today Only'),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  CommonButton(
                    width: 120,
                    text: 'Search',
                    icon: Icons.search,
                    onTap: () async {
                      controller.searchCustomers();
                    },
                  ),
                  CommonButton(
                    width: 120,
                    text: 'Reset',
                    icon: Icons.refresh,
                    color: AppColors.backgroundColor,
                    textColor: AppColors.primaryColor,
                    onTap: () async {
                      // Reset search filters
                      controller.resetSearchFilters();
                    },
                  ),
                  Spacer(),
                  CommonButton(
                    text: 'Add New',
                    icon: Icons.add,
                    onTap: () async {
                      await controller.openAddEditPopup(CustomerMaster());
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
                  SizedBox(
                    width: 50,
                    child: Text(
                      '',
                      textAlign: TextAlign.center,
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
                    width: 150,
                    child: Text(
                      'Mobile',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Balance',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Since',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Cluster Name',
                      textAlign: TextAlign.left,
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
                    ...List.generate(controller.customers.length, (index) {
                      var customer = controller.customers[index];
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
                            
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  if(customer.isApproved == false){
                                    controller.approveCustomer(customer);
                                  }
                                },
                                child: SizedBox(
                                  width: 50,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: customer.isApproved == true
                                        ? Icon(
                                            Icons.verified,
                                            color: AppColors.successColor,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.person_off_rounded,
                                            color: AppColors.errorColor,
                                            size: 20,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  '${customer.firstName ?? ''} ${customer.lastName ?? ''}',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                customer.mobile ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                '${customer.balance?.toStringAsFixed(2) ?? '0.00'} (Limit: ${customer.allowLimit?.toStringAsFixed(2) ?? '0.00'})',
                                textAlign: TextAlign.left,
                              ),
                            ), SizedBox(
                              width: 80,
                              child: Text(
                                customer.createdDate ?? '',
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
                                  width: 80,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: customer.isActive == true
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
                              width: 150,
                              child: Text(
                                customer.clusterMasterName ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await controller.openBalanceAccountPopup(
                                        customer,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.currency_rupee,
                                        size: 30,
                                        color: AppColors.warningColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await controller.openAddressPopup(
                                        customer,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        size: 30,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ),
                                  
                                  InkWell(
                                    onTap: () async {
                                      await controller.openAddEditPopup(
                                        customer,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: AppColors.infoColor,
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     controller.deleteCustomer(customer);
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Icon(
                                  //       Icons.delete,
                                  //       size: 20,
                                  //       color: AppColors.errorColor,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (controller.customers.isEmpty)
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
                      'Total Customers: ${controller.totalRecords.value}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
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
