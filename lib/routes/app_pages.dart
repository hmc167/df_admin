import 'package:get/get.dart';
import '../views/login_view.dart';
import '../bindings/login_binding.dart';
import '../views/dashboard_view.dart';
import '../bindings/dashboard_binding.dart';
import '../views/productcategory_view.dart';
import '../bindings/productcategory_binding.dart';
import '../views/unitvariant_view.dart';
import '../bindings/unitvariant_binding.dart';
import '../views/products_view.dart';
import '../bindings/products_binding.dart';
import '../views/outofstock_view.dart';
import '../bindings/outofstock_binding.dart';
import '../views/newarrival_view.dart';
import '../bindings/newarrival_binding.dart';
import '../views/suggestsproduct_view.dart';
import '../bindings/suggestsproduct_binding.dart';
import '../views/deliveryzone_view.dart';
import '../bindings/deliveryzone_binding.dart';
import '../views/customers_view.dart';
import '../bindings/customers_binding.dart';
import '../views/customerinquiry_view.dart';
import '../bindings/customerinquiry_binding.dart';
import '../views/farmers_view.dart';
import '../bindings/farmers_binding.dart';
import '../views/farmersaccount_view.dart';
import '../bindings/farmersaccount_binding.dart';
import '../views/orders_view.dart';
import '../bindings/orders_binding.dart';
import '../views/dailyorders_view.dart';
import '../bindings/dailyorders_binding.dart';
import '../views/advertisements_view.dart';
import '../bindings/advertisements_binding.dart';
import '../views/homesliders_view.dart';
import '../bindings/homesliders_binding.dart';
import '../views/expensecategory_view.dart';
import '../bindings/expensecategory_binding.dart';
import '../views/expenses_view.dart';
import '../bindings/expenses_binding.dart';
import '../views/platformfees_view.dart';
import '../bindings/platformfees_binding.dart';
import '../views/deliverycharge_view.dart';
import '../bindings/deliverycharge_binding.dart';
import '../views/taxmaster_view.dart';
import '../bindings/taxmaster_binding.dart';
import '../views/statedistrict_view.dart';
import '../bindings/statedistrict_binding.dart';
import '../views/taluka_view.dart';
import '../bindings/taluka_binding.dart';
import '../views/villagepincode_view.dart';
import '../bindings/villagepincode_binding.dart';
import '../views/usermodules_view.dart';
import '../bindings/usermodules_binding.dart';
import '../views/rolerights_view.dart';
import '../bindings/rolerights_binding.dart';
import '../views/users_view.dart';
import '../bindings/users_binding.dart';
import '../views/reportorder_view.dart';
import '../bindings/reportorder_binding.dart';
import '../views/reportcustomer_view.dart';
import '../bindings/reportcustomer_binding.dart';
import '../views/reportdailyorderproduct_view.dart';
import '../bindings/reportdailyorderproduct_binding.dart';
import '../views/reportproduct_view.dart';
import '../bindings/reportproduct_binding.dart';
import '../views/reportfarmersaccount_view.dart';
import '../bindings/reportfarmersaccount_binding.dart';
import '../views/reportdailyfarmersaccount_view.dart';
import '../bindings/reportdailyfarmersaccount_binding.dart';
import '../views/reportexpenses_view.dart';
import '../bindings/reportexpenses_binding.dart';
import '../views/reportusers_view.dart';
import '../bindings/reportusers_binding.dart';
import '../views/reportuseractivity_view.dart';
import '../bindings/reportuseractivity_binding.dart';
import '../views/balancedaily_view.dart';
import '../bindings/balancedaily_binding.dart';
import '../views/balanceweekly_view.dart';
import '../bindings/balanceweekly_binding.dart';
import '../views/balancemonthly_view.dart';
import '../bindings/balancemonthly_binding.dart';
import '../views/balancedaterange_view.dart';
import '../bindings/balancedaterange_binding.dart';
import '../views/changepassword_view.dart';
import '../bindings/changepassword_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.LOGIN;
  //static const initial = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTCATEGORY,
      page: () => ProductCategoryView(),
      binding: ProductCategoryBinding(),
    ),
    GetPage(
      name: Routes.UNITVARIANT,
      page: () => UnitVariantView(),
      binding: UnitVariantBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.OUTOFSTOCK,
      page: () => OutOfStockView(),
      binding: OutOfStockBinding(),
    ),
    GetPage(
      name: Routes.NEWARRIVAL,
      page: () => NewArrivalView(),
      binding: NewArrivalBinding(),
    ),
    GetPage(
      name: Routes.SUGGESTSPRODUCT,
      page: () => SuggestsProductView(),
      binding: SuggestsProductBinding(),
    ),
    GetPage(
      name: Routes.DELIVERYZONE,
      page: () => DeliveryZoneView(),
      binding: DeliveryZoneBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMERS,
      page: () => CustomersView(),
      binding: CustomersBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMERINQUIRY,
      page: () => CustomerInquiryView(),
      binding: CustomerInquiryBinding(),
    ),
    GetPage(
      name: Routes.FARMERS,
      page: () => FarmersView(),
      binding: FarmersBinding(),
    ),
    GetPage(
      name: Routes.FARMERSACCOUNT,
      page: () => FarmersAccountView(),
      binding: FarmersAccountBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: Routes.DAILYORDERS,
      page: () => DailyOrdersView(),
      binding: DailyOrdersBinding(),
    ),
    GetPage(
      name: Routes.ADVERTISEMENTS,
      page: () => AdvertisementsView(),
      binding: AdvertisementsBinding(),
    ),
    GetPage(
      name: Routes.HOMESLIDERS,
      page: () => HomeSlidersView(),
      binding: HomeSlidersBinding(),
    ),
    GetPage(
      name: Routes.EXPENSECATEGORY,
      page: () => ExpenseCategoryView(),
      binding: ExpenseCategoryBinding(),
    ),
    GetPage(
      name: Routes.EXPENSES,
      page: () => ExpensesView(),
      binding: ExpensesBinding(),
    ),
    GetPage(
      name: Routes.PLATFORMFEES,
      page: () => PlatformFeesView(),
      binding: PlatformFeesBinding(),
    ),
    GetPage(
      name: Routes.DELIVERYCHARGE,
      page: () => DeliveryChargeView(),
      binding: DeliveryChargeBinding(),
    ),
    GetPage(
      name: Routes.TAXMASTER,
      page: () => TaxMasterView(),
      binding: TaxMasterBinding(),
    ),
    GetPage(
      name: Routes.STATEDISTRICT,
      page: () => StateDistrictView(),
      binding: StateDistrictBinding(),
    ),
    GetPage(
      name: Routes.TALUKA,
      page: () => TalukaView(),
      binding: TalukaBinding(),
    ),
    GetPage(
      name: Routes.VILLAGEPINCODE,
      page: () => VillagePincodeView(),
      binding: VillagePincodeBinding(),
    ),
    GetPage(
      name: Routes.USERMODULES,
      page: () => UserModulesView(),
      binding: UserModulesBinding(),
    ),
    GetPage(
      name: Routes.ROLERIGHTS,
      page: () => RoleRightsView(),
      binding: RoleRightsBinding(),
    ),
    GetPage(
      name: Routes.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: Routes.REPORTORDER,
      page: () => ReportOrderView(),
      binding: ReportOrderBinding(),
    ),
    GetPage(
      name: Routes.REPORTCUSTOMER,
      page: () => ReportCustomerView(),
      binding: ReportCustomerBinding(),
    ),
    GetPage(
      name: Routes.REPORTDAILYORDERPRODUCT,
      page: () => ReportDailyOrderProductView(),
      binding: ReportDailyOrderProductBinding(),
    ),
    GetPage(
      name: Routes.REPORTPRODUCT,
      page: () => ReportProductView(),
      binding: ReportProductBinding(),
    ),
    GetPage(
      name: Routes.REPORTFARMERSACCOUNT,
      page: () => ReportFarmersAccountView(),
      binding: ReportFarmersAccountBinding(),
    ),
    GetPage(
      name: Routes.REPORTDAILYFARMERSACCOUNT,
      page: () => ReportDailyFarmersAccountView(),
      binding: ReportDailyFarmersAccountBinding(),
    ),
    GetPage(
      name: Routes.REPORTEXPENSES,
      page: () => ReportExpensesView(),
      binding: ReportExpensesBinding(),
    ),
    GetPage(
      name: Routes.REPORTUSERS,
      page: () => ReportUsersView(),
      binding: ReportUsersBinding(),
    ),
    GetPage(
      name: Routes.REPORTUSERACTIVITY,
      page: () => ReportUserActivityView(),
      binding: ReportUserActivityBinding(),
    ),
    GetPage(
      name: Routes.BALANCEDAILY,
      page: () => BalanceDailyView(),
      binding: BalanceDailyBinding(),
    ),
    GetPage(
      name: Routes.BALANCEWEEKLY,
      page: () => BalanceWeeklyView(),
      binding: BalanceWeeklyBinding(),
    ),
    GetPage(
      name: Routes.BALANCEMONTHLY,
      page: () => BalanceMonthlyView(),
      binding: BalanceMonthlyBinding(),
    ),
    GetPage(
      name: Routes.BALANCEDATERANGE,
      page: () => BalanceDateRangeView(),
      binding: BalanceDateRangeBinding(),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
