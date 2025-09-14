import 'package:admin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController controller = Get.put(DashboardController());

  TextEditingController productSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  TextEditingController orderSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardWidth = width > 600 ? ((width - 62) / 2) : (width - 32);

    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Search', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: productSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search Product by name or code',
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(
                        onTap: () {
                          searchProduct();
                        },
                        child: Icon(Icons.forward, color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      searchProduct();
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: customerSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search Customer by name or mobile',
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(onTap: () {
                        searchCustomers();
                      }, child: Icon(Icons.forward, color: Colors.black)),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      searchCustomers();
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: orderSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search Order by number',
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(onTap: () {
                        searchOrders();
                      }, child: Icon(Icons.forward, color: Colors.black)),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      searchOrders();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  'Statistics',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    controller.refreshDashboard();
                  },
                  icon: Icon(Icons.restore),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => Wrap(
                runAlignment: WrapAlignment.start,
                spacing: 30,
                runSpacing: 30,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    width: cardWidth,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Orders-DailyOrders',
                                  );
                                  Get.offAllNamed(Routes.DAILYORDERS);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller.dashboardData.value.totalOrder
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Total'),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Orders-DailyOrders',
                                  );
                                  Get.offAllNamed(Routes.DAILYORDERS);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller.dashboardData.value.lockOrder
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Locked'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Daily Order Count'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              loginController.selectMenu('Products-Category');
                              Get.offAllNamed(Routes.PRODUCTCATEGORY);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              height: 130,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        controller
                                                .dashboardData
                                                .value
                                                .totalCategory
                                                ?.toString() ??
                                            '0',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Total Category'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              loginController.selectMenu(
                                'Customers-CustomerInquiry',
                              );
                              Get.offAllNamed(Routes.CUSTOMERINQUIRY);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              height: 130,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        controller
                                                .dashboardData
                                                .value
                                                .totalCustomerInquiry
                                                ?.toString() ??
                                            '0',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Customer Inquiry'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    width: cardWidth,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu('Products');
                                  Get.offAllNamed(Routes.PRODUCTS);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalProduct
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Total'),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  loginController.selectMenu('Products');
                                  Get.offAllNamed(
                                    Routes.PRODUCTS,
                                    arguments: {'status': 1},
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalProductActive
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Active'),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu('Products');
                                  Get.offAllNamed(
                                    Routes.PRODUCTS,
                                    arguments: {'status': 2},
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalProductInActive
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('InActive'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Product Count'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    width: cardWidth,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Customers-Customers',
                                  );
                                  Get.offAllNamed(Routes.CUSTOMERS);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalCustomer
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Total'),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Customers-Customers',
                                  );
                                  Get.offAllNamed(
                                    Routes.CUSTOMERS,
                                    arguments: {'todayonly': true},
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalTodayCustomer
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Todays register'),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Customers-Customers',
                                  );
                                  Get.offAllNamed(
                                    Routes.CUSTOMERS,
                                    arguments: {'approved': 1},
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalCustomerApproved
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Approved'),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  loginController.selectMenu(
                                    'Customers-Customers',
                                  );
                                  Get.offAllNamed(
                                    Routes.CUSTOMERS,
                                    arguments: {'approved': 2},
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      controller
                                              .dashboardData
                                              .value
                                              .totalCustomerPending
                                              ?.toString() ??
                                          '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Pending'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Customers Count'),
                        ),
                      ],
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

  void searchProduct() {
    var searchText = productSearchController.text.trim();
    if (searchText.isNotEmpty) {
      loginController.selectMenu('Products');
      Get.offAllNamed(Routes.PRODUCTS, arguments: {'search': searchText});
    }
  }

  void searchCustomers() {
    var searchText = customerSearchController.text.trim();
    if (searchText.isNotEmpty) {
      loginController.selectMenu('Customers');
      Get.offAllNamed(Routes.CUSTOMERS, arguments: {'search': searchText});
    }
  }

  void searchOrders() {
    var searchText = orderSearchController.text.trim();
    if (searchText.isNotEmpty) {
      loginController.selectMenu('Orders');
      Get.offAllNamed(Routes.ORDERS, arguments: {'search': searchText});
    }
  }
}
