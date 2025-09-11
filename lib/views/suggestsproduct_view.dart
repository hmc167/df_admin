import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/suggestsproduct_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/common_button.dart';

class SuggestsProductView extends StatefulWidget {
  const SuggestsProductView({super.key});

  @override
  State<SuggestsProductView> createState() => _SuggestsProductViewState();
}

class _SuggestsProductViewState extends State<SuggestsProductView> {
  final SuggestsProductController controller = Get.put(
    SuggestsProductController(),
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
              'Product Suggestions',
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
                        DropdownMenuItem(value: -1, child: Text('All')),
                        DropdownMenuItem(value: 0, child: Text(statusString(0))),
                        DropdownMenuItem(value: 1, child: Text(statusString(1))),
                        DropdownMenuItem(value: 2, child: Text(statusString(2))),
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
                      controller.searchSuggests();
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
                    width: 250,
                    child: Text(
                      'Suggested By',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Suggested Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.right,
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
                    ...List.generate(controller.suggests.length, (index) {
                      var suggest = controller.suggests[index];
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
                                  suggest.name ?? '',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),                            
                            SizedBox(
                              width: 250,
                              child: Text(
                                suggest.createdBy ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                suggest.createdDate??'',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                statusString(suggest.status ?? 0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // await controller.changeStatusSuggest(
                                      //   suggest,
                                      // );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: AppColors.infoColor,
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     controller.deleteSuggest(suggest);
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
                      'Total Suggestions: ${controller.suggests.length}',
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

  String statusString(int status) {
  switch (status) {
    case 0:
      return 'New';
    case 1:
      return 'In Review';
    case 2:
      return 'Approved (Added)';
    default:
      return 'Unknown';
  }
}
}
