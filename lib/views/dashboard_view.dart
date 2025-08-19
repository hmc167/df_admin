import 'package:admin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../routes/app_pages.dart';
import '../widgets/appbar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController controller = Get.put(DashboardController());
  @override 
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardWidth = width > 600 ? ((width - 62) / 2) : (width - 32);

    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
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
                    decoration: InputDecoration(
                      hintText: 'Search Product by name or code',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.forward, color: Colors.black),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      // Handle search logic here
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search Customer by name or mobile',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.forward, color: Colors.black),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      // Handle search logic here
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search Order by number',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.forward, color: Colors.black),
                    ),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                    onFieldSubmitted: (value) {
                      // Handle search logic here
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
            Wrap(
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
                                    '123',
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
                                    '60',
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
                InkWell(
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
                    width: cardWidth,
                    height: 130,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              '20',
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
                                    '98',
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
                                Get.offAllNamed(Routes.PRODUCTS);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '88',
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
                                Get.offAllNamed(Routes.PRODUCTS);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '10',
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
                                    '98',
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
                                Get.offAllNamed(Routes.CUSTOMERS);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '88',
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
                                  'Customers-CustomerInquiry',
                                );
                                Get.offAllNamed(Routes.CUSTOMERINQUIRY);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('Pending Inquiry'),
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
          ],
        ),
      ),
    );
  }
}
