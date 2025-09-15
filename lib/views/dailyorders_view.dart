import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dailyorders_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class DailyOrdersView extends StatefulWidget {
  const DailyOrdersView({super.key});

  @override
  State<DailyOrdersView> createState() => _DailyOrdersViewState();
}

class _DailyOrdersViewState extends State<DailyOrdersView> {
  final DailyOrdersController controller = Get.put(DailyOrdersController());
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
              'UnLock Requests',
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
                      value: controller.filterStatus.value,
                      hint: Text('Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(value: null, enabled: false, child: Text('Status'),),
                        DropdownMenuItem(value: 0, child: Text('New')),
                        DropdownMenuItem(value: 1, child: Text('Done')),
                      ],
                      onChanged: (value) {
                        controller.filterStatus.value = value ?? 0;
                      },
                    ),
                  ),
                  
                  SizedBox(width: 20),
                  CommonButton(
                    width: 120,
                    text: 'Search',
                    icon: Icons.search,
                    onTap: () async {
                      controller.search();
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
                    width: 200,
                    child: Text(
                      'Remarks',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Order ID',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ), 
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Order Notes',
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
                    ...List.generate(controller.unLockRequests.length, (index) {
                      var unlockRequest = controller.unLockRequests[index];
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
                                  unlockRequest.customerName ?? '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                unlockRequest.remarks ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                ((unlockRequest.orderId ?? 0) == 0) ? '' : unlockRequest.orderId.toString(),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text(
                                (unlockRequest.totalAmount ?? 0).toStringAsFixed(2),
                                textAlign: TextAlign.left,
                              ),
                            ),
                             SizedBox(
                              width: 200,
                              child: Text(
                                unlockRequest.notes ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            // MouseRegion(
                            //   cursor: SystemMouseCursors.click,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       //
                            //     },
                            //     child: SizedBox(
                            //       width: 80,
                            //       child: Align(
                            //         alignment: Alignment.center,
                            //         child: unlockRequest.status == true
                            //             ? Icon(
                            //                 Icons.check_circle,
                            //                 color: AppColors.successColor,
                            //                 size: 20,
                            //               )
                            //             : Icon(
                            //                 Icons.close,
                            //                 color: AppColors.errorColor,
                            //                 size: 20,
                            //               ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                                                        
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(controller.filterStatus.value == 0)                                  
                                  InkWell(
                                    onTap: () async {
                                      controller.editUnlockRequest(unlockRequest);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.verified,
                                        size: 30,
                                        color: AppColors.infoColor,
                                      ),
                                    ),
                                  ),
                                   InkWell(
                                     onTap: () {
                                       controller.deleteUnlockRequest(unlockRequest);
                                     },
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Icon(
                                         Icons.delete,
                                         size: 30,
                                         color: AppColors.errorColor,
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
                    if (controller.unLockRequests.isEmpty)
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
                      'Total Unlock Requests: ${controller.totalRecords.value}',
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
