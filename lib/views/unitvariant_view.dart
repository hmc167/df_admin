import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/unitvariant_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class UnitVariantView extends StatefulWidget {
  const UnitVariantView({super.key});

  @override
  State<UnitVariantView> createState() => _UnitVariantViewState();
}

class _UnitVariantViewState extends State<UnitVariantView> {
  final UnitVariantController controller = Get.put(UnitVariantController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: AppColors.textColorWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unit Category',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.filterNameCategoryController,
                          decoration: InputDecoration(
                            labelText: 'Search by Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: controller.searchUnitVariants,
                        child: Text('Search'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: controller.resetSearchFilters,
                        child: Text('Reset'),
                      ),
                      
                      // ElevatedButton.icon(
                      //   icon: Icon(Icons.add),
                      //   label: Text('Add Unit Variant'),
                      //   onPressed: () {
                      //     controller.openAddUnitVariantPopup();
                      //   },
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                          width: 90,
                          child: Text(
                            'Sort Order',
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
                          ...List.generate(controller.unitCategories.length, (index) {
                            var category = controller.unitCategories[index];
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
                                        category.name ?? '',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
              
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      category.sortOrder?.toString() ?? '0',
                                      textAlign: TextAlign.center,
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
                            'Total Categories: ${controller.unitCategories.length}',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.textColorWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit Variants',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.filterNameController,
                            decoration: InputDecoration(
                              labelText: 'Search by Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: controller.searchUnitVariants,
                          child: Text('Search'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: controller.resetSearchFilters,
                          child: Text('Reset'),
                        ),
                        Spacer(),
                        // ElevatedButton.icon(
                        //   icon: Icon(Icons.add),
                        //   label: Text('Add Unit Variant'),
                        //   onPressed: () {
                        //     controller.openAddUnitVariantPopup();
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                            width: 200,
                            child: Text(
                              'Category',
                              textAlign: TextAlign.left,
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
                              'Multiplier',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),                
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Sort Order',
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
                            ...List.generate(controller.unitVariants.length, (index) {
                              var unitVariant = controller.unitVariants[index];
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
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        unitVariant.unitCategoryName?.toString() ?? '0',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          unitVariant.name ?? '',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        unitVariant.multiplier?.toStringAsFixed(2) ?? '0.00',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),                
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        unitVariant.sortOrder?.toString() ?? '0',
                                        textAlign: TextAlign.center,
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
                              'Total Unit Variants: ${controller.unitVariants.length}',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),)
          ],
        ),
      ),
    );
  }
}
