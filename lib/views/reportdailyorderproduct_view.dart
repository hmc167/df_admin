import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportdailyorderproduct_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';
import '../widgets/html_pdf_preview.dart';

class ReportDailyOrderProductView extends StatefulWidget {
  const ReportDailyOrderProductView({super.key});

  @override
  State<ReportDailyOrderProductView> createState() =>
      _ReportDailyOrderProductViewState();
}

class _ReportDailyOrderProductViewState
    extends State<ReportDailyOrderProductView> {
  final ReportDailyOrderProductController controller = Get.put(
    ReportDailyOrderProductController(),
  );
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
              'Order Estimates',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(15.0),
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
                  SizedBox(width: 20),
                  SizedBox(
                    width: 160,
                    child: TextField(
                      controller: controller.filterOrderDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Order Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate:
                              controller.filterOrderDate.value ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          controller.filterOrderDate.value = picked;
                          controller.filterOrderDateController.text =
                              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Switch(
                          value: controller.includeUnLockItem.value,
                          onChanged: (value) {
                            controller.includeUnLockItem.value = value;
                          },
                        ),
                        Text('Include Unlocked Items'),
                      ],
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Switch(
                          value: controller.onlyItemDetails.value,
                          onChanged: (value) {
                            controller.onlyItemDetails.value = value;
                          },
                        ),
                        Text('Show order item details'),
                      ],
                    ),
                  ),
                  CommonButton(
                    width: 150,
                    text: 'Generate',
                    icon: Icons.search,
                    onTap: () async {
                      controller.generate();
                    },
                  ),
                  CommonButton(
                    width: 150,
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
                    width: 150,
                    text: 'Download',
                    icon: Icons.download,
                    onTap: () async {
                      await controller.savePdf('OrderEstimateReport_${controller.filterOrderDateController.text.replaceAll('-', '')}.pdf');
                    },
                  ),
                  // CommonButton(
                  //   width: 110,
                  //   text: 'Export',
                  //   icon: Icons.file_download,
                  //   onTap: () async {
                  //     controller.openInSystemBrowser();
                  //   },
                  // ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.orderEstimates.isEmpty
                    ? Center(child: Text('No data available'))
                    //: //SingleChildScrollView(
                        // child: Center(
                        //   child: SelectableText(
                        //     controller.reportString.value,
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       fontFamily: 'CourierPrime',
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),                        
                      //),
                     : HtmlPdfPreview(
                         html: controller.reportString.value,
                         pdfFileName:
                             'Order_Estimate_${controller.filterOrderDateController.text.replaceAll('-', '')}.pdf',
                       ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
