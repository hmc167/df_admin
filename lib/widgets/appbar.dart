import 'package:admin/routes/app_pages.dart';
import 'package:admin/utils/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../main.dart';

AppBar getAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Dhanfuliya Fresh Admin",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Spacer(),
        Text(
          DateTime.now().toDateFormat('dd MMMM yyyy'),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 20),
        Row(
          children: [
            // InkWell(
            //   onTap: () {
            //     //
            //   },
            //   child: Badge.count(
            //     count: 20,
            //     child: Icon(Icons.notifications, color: Colors.white),
            //   ),
            // ),
            SizedBox(width: 20),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Logout') loginController.logout();
              },
              itemBuilder: (BuildContext context) {
                return {'Profile', 'Change Password', 'Logout'}
                    .map(
                      (String choice) => PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      ),
                    )
                    .toList();
              },
              child: Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  SizedBox(width: 5),
                  Text("Admin", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    backgroundColor: Colors.blueGrey,
  );
}

Widget getAppDrawer() {
  return Drawer(
    backgroundColor: Colors.white,
    width: 350,
    elevation: 6.0,
    shape: ShapeBorder.lerp(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      0.5,
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blueGrey),
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dhanfuliya Fresh Admin',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                'v 1.0.0',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text('Dashboard', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.dashboard_outlined, color: Colors.black),
          onTap: loginController.selectedMenu.value == 'Dashboard'
              ? null
              : () {
                  loginController.selectMenu('Dashboard');
                  Get.offAllNamed(Routes.DASHBOARD);
                },
          selected: loginController.selectedMenu.value == 'Dashboard',
          selectedTileColor: Colors.blueGrey[100],
        ),
        ExpansionTile(
          title: Text('Products', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.menu, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Products',
          ),
          children: [
            ListTile(
              title: Text('Category', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Products-Category');
                Get.offAllNamed(Routes.PRODUCTCATEGORY);
              },
              selected:
                  loginController.selectedMenu.value == 'Products-Category',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Unit - Variant',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Products-UnitVariant');
                Get.offAllNamed(Routes.UNITVARIANT);
              },
              selected:
                  loginController.selectedMenu.value == 'Products-UnitVariant',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Products', style: TextStyle(color: Colors.black)),
              onTap: loginController.selectedMenu.value == 'Products'
                  ? null
                  : () {
                      loginController.selectMenu('Products');
                      Get.offAllNamed(Routes.PRODUCTS);
                    },
              selected: loginController.selectedMenu.value == 'Products',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Out Of Stock Manage',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Products-OutOfStock');
                Get.offAllNamed(Routes.OUTOFSTOCK);
              },
              selected:
                  loginController.selectedMenu.value == 'Products-OutOfStock',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('New Arrival', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Products-NewArrival');
                Get.offAllNamed(Routes.NEWARRIVAL);
              },
              selected:
                  loginController.selectedMenu.value == 'Products-NewArrival',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Suggests Product',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Products-SuggestsProduct');
                Get.offAllNamed(Routes.SUGGESTSPRODUCT);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Products-SuggestsProduct',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Customer', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.people_outline, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Customers',
          ),
          children: [
            ListTile(
              title: Text('Customers', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Customers-Customers');
                Get.offAllNamed(Routes.CUSTOMERS);
              },
              selected:
                  loginController.selectedMenu.value == 'Customers-Customers',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Customer Inquiry',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Customers-CustomerInquiry');
                // Replace with your route for Customer Inquiry
                Get.offAllNamed(Routes.CUSTOMERINQUIRY);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'DeliveryZone-CustomerInquiry',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Farmers', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.people_alt_outlined, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Farmers',
          ),
          children: [
            ListTile(
              title: Text('Farmers', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Farmers');
                Get.offAllNamed(Routes.FARMERS);
              },
              selected: loginController.selectedMenu.value == 'Farmers',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Accounts', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Farmers-Accounts');
                Get.offAllNamed(Routes.FARMERSACCOUNT);
              },
              selected:
                  loginController.selectedMenu.value == 'Farmers-Accounts',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Orders', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.shopping_bag_outlined, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Orders',
          ),
          children: [
            ListTile(
              title: Text('Order', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Orders-Order');
                Get.offAllNamed(Routes.ORDERS);
              },
              selected: loginController.selectedMenu.value == 'Orders-Order',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'UnLock Requests',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Orders-DailyOrders');
                Get.offAllNamed(Routes.DAILYORDERS);
              },
              selected:
                  loginController.selectedMenu.value == 'Orders-DailyOrders',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Promotion', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.card_giftcard, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Promotion',
          ),
          children: [
            ListTile(
              title: Text(
                'Advertisement',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Promotion-Advertisement');
                // Replace with your route for Advertisement
                Get.offAllNamed(Routes.ADVERTISEMENTS);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Promotion-Advertisement',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Home Sliders',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Promotion-HomeSliders');
                // Replace with your route for Home Sliders
                Get.offAllNamed(Routes.HOMESLIDERS);
              },
              selected:
                  loginController.selectedMenu.value == 'Promotion-HomeSliders',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Expense Manage', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.payment, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Expense',
          ),
          children: [
            ListTile(
              title: Text(
                'Expense Category',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Expense-Category');
                Get.offAllNamed(Routes.EXPENSECATEGORY);
              },
              selected:
                  loginController.selectedMenu.value == 'Expense-Category',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Expenses', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Expense-Expenses');
                Get.offAllNamed(Routes.EXPENSES);
              },
              selected:
                  loginController.selectedMenu.value == 'Expense-Expenses',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Settings', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.settings_outlined, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Settings',
          ),
          children: [
            ListTile(
              title: Text(
                'Delivery Zone (Cluster)',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Customers-Cluster');
                // Replace with your route for Cluster
                Get.offAllNamed(Routes.DELIVERYZONE);
              },
              selected:
                  loginController.selectedMenu.value == 'Customers-Cluster',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Cluster Wise Platform Fees',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Settings-ClusterPlatformFees');
                Get.offAllNamed(Routes.PLATFORMFEES);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Settings-ClusterPlatformFees',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Cluster Wise Delivery Charge',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Settings-ClusterDeliveryCharge');
                Get.offAllNamed(Routes.DELIVERYCHARGE);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Settings-ClusterDeliveryCharge',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Tax Master', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Settings-TaxMaster');
                Get.offAllNamed(Routes.TAXMASTER);
              },
              selected:
                  loginController.selectedMenu.value == 'Settings-TaxMaster',
              selectedTileColor: Colors.blueGrey[100],
            ),

            ExpansionTile(
              title: Text(
                'Support Location',
                style: TextStyle(color: Colors.black),
              ),
              initiallyExpanded: loginController.selectedMenu.value.startsWith(
                'Location',
              ),
              children: [
                ListTile(
                  title: Text(
                    'State & District',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    loginController.selectMenu('Location-State-District');
                    Get.offAllNamed(Routes.STATEDISTRICT);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Location-State-District',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text('Taluka', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    loginController.selectMenu('Location-Taluka');
                    Get.offAllNamed(Routes.TALUKA);
                  },
                  selected:
                      loginController.selectedMenu.value == 'Location-Taluka',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text(
                    'Village/Town with Pincode',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    loginController.selectMenu('Location-VillageTownPincode');
                    Get.offAllNamed(Routes.VILLAGEPINCODE);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Location-VillageTownPincode',
                  selectedTileColor: Colors.blueGrey[100],
                ),
              ],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('User', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.person_outline, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'User',
          ),
          children: [
            ListTile(
              title: Text('Modules', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('User-Modules');
                Get.offAllNamed(Routes.USERMODULES);
              },
              selected: loginController.selectedMenu.value == 'User-Modules',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Role Rights', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('User-RoleRights');
                Get.offAllNamed(Routes.ROLERIGHTS);
              },
              selected: loginController.selectedMenu.value == 'User-RoleRights',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Users', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('User-Users');
                Get.offAllNamed(Routes.USERS);
              },
              selected: loginController.selectedMenu.value == 'User-Users',
              selectedTileColor: Colors.blueGrey[100],
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Reports', style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.stacked_bar_chart_outlined, color: Colors.black),
          childrenPadding: EdgeInsets.only(left: 30),
          initiallyExpanded: loginController.selectedMenu.value.startsWith(
            'Reports',
          ),
          children: [
            ListTile(
              title: Text('Order', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Reports-Order');
                Get.offAllNamed(Routes.ORDERS);
              },
              selected: loginController.selectedMenu.value == 'Reports-Order',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Customer', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Reports-Customer');
                Get.offAllNamed(Routes.CUSTOMERS);
              },
              selected:
                  loginController.selectedMenu.value == 'Reports-Customer',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Daily Order Product',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Reports-DailyOrderProduct');
                Get.offAllNamed(Routes.REPORTDAILYORDERPRODUCT);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Reports-DailyOrderProduct',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Product', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Reports-Product');
                Get.offAllNamed(Routes.PRODUCTS);
              },
              selected: loginController.selectedMenu.value == 'Reports-Product',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Farmers Account',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Reports-FarmersAccount');
                Get.offAllNamed(Routes.FARMERSACCOUNT);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Reports-FarmersAccount',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text(
                'Daily Farmers Account',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                loginController.selectMenu('Reports-DailyFarmersAccount');
                Get.offAllNamed(Routes.REPORTFARMERSACCOUNT);
              },
              selected:
                  loginController.selectedMenu.value ==
                  'Reports-DailyFarmersAccount',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ListTile(
              title: Text('Expenses', style: TextStyle(color: Colors.black)),
              onTap: () {
                loginController.selectMenu('Reports-Expenses');
                Get.offAllNamed(Routes.EXPENSES);
              },
              selected:
                  loginController.selectedMenu.value == 'Reports-Expenses',
              selectedTileColor: Colors.blueGrey[100],
            ),
            ExpansionTile(
              title: Text('Users', style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.person_outline, color: Colors.black),
              childrenPadding: EdgeInsets.only(left: 30),
              initiallyExpanded: loginController.selectedMenu.value.startsWith(
                'Reports-Users',
              ),
              children: [
                ListTile(
                  title: Text('Users', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    loginController.selectMenu('Reports-Users');
                    Get.offAllNamed(Routes.REPORTUSERS);
                  },
                  selected:
                      loginController.selectedMenu.value == 'Reports-Users',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text(
                    'Users Activity',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    loginController.selectMenu('Reports-UsersActivity');
                    Get.offAllNamed(Routes.REPORTUSERACTIVITY);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Reports-UsersActivity',
                  selectedTileColor: Colors.blueGrey[100],
                ),
              ],
            ),

            ExpansionTile(
              title: Text('Balance', style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.balance_outlined, color: Colors.black),
              childrenPadding: EdgeInsets.only(left: 30),
              initiallyExpanded: loginController.selectedMenu.value.startsWith(
                'Reports-Balance',
              ),
              children: [
                ListTile(
                  title: Text('Daily', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    loginController.selectMenu('Reports-Balance-Daily');
                    Get.offAllNamed(Routes.BALANCEDAILY);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Reports-Balance-Daily',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text('Weekly', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    loginController.selectMenu('Reports-Balance-Weekly');
                    Get.offAllNamed(Routes.BALANCEWEEKLY);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Reports-Balance-Weekly',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text('Monthly', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    loginController.selectMenu('Reports-Balance-Monthly');
                    Get.offAllNamed(Routes.BALANCEMONTHLY);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Reports-Balance-Monthly',
                  selectedTileColor: Colors.blueGrey[100],
                ),
                ListTile(
                  title: Text(
                    'Date Range',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    loginController.selectMenu('Reports-Balance-DateRange');
                    Get.offAllNamed(Routes.BALANCEDATERANGE);
                  },
                  selected:
                      loginController.selectedMenu.value ==
                      'Reports-Balance-DateRange',
                  selectedTileColor: Colors.blueGrey[100],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}
