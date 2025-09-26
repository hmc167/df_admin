class ApiList {
  static const String login = "api/User/login";
  static const String getDashboard = "api/User/dashboard";
  static const String changePassword = "api/User/change-password";


  static const String getDashboardSummary = "api/ClusterMaster/dashboard-summary";
  static const String getClusters = "api/ClusterMaster/all";
  static const String getDeliverySlots = "api/ClusterMaster/all-deliveryslots";
  
  static const String getCategoryMaster = "api/CategoryMaster/all";
  static const String saveCategoryMaster = "api/CategoryMaster/insertupdate";
  static const String changeCategoryStatus = "api/CategoryMaster/change-status";

  
  static const String getUnitMaster = "api/UnitMaster/all";
  static const String saveUnitCategoryMaster = "api/UnitMaster/all-unit-category";

  
  static const String getProductMaster = "api/ProductMaster/get";
  static const String getListProductMaster = "api/ProductMaster/all";
  static const String saveProductMaster = "api/ProductMaster/insertupdate";
  static const String changeProductStatus = "api/ProductMaster/change-status";
  static const String saveProductVariant = "api/ProductMaster/variant-insertupdate";
  static const String getVariants = "api/ProductMaster/all-variant";
  static const String getProductSearch = "api/ProductMaster/list";

  
  static const String getProductSuggests = "api/ProductMaster/suggests-all";
  static const String changeProductSuggestsStatus = "api/ProductMaster/suggests-change-status";

  static const String getAllCustomer = "api/Customer/all";
  static const String saveCustomer = "api/Customer/insertupdate";
  static const String changeCustomerStatus = "api/Customer/change-status";
  static const String getAllCustomerAddress = "api/Customer/all-address";
  static const String saveCustomerAddress = "api/Customer/insertupdate-address";
  static const String addCustomerBalance = "api/Customer/add-balance";
  static const String getCustomerBalanceHistory = "api/Customer/balance-history";
  
  static const String searchCustomer = "api/Customer/search";

  static const String getUnLockRequests = "api/Order/all-unlock-request";
  static const String changeUnLockRequestStatus = "api/Order/unlock-request-change-status";

  static const String getOrders = "api/Order/all";
  static const String getOrderDetails = "api/Order/get";
  static const String changeOrderStatus = "api/Order/change-status";
  static const String orderCreate = "api/Order/create";
  static const String orderAddItem = "api/Order/add-item";
  static const String orderUpdateItem = "api/Order/modify-item";
  static const String orderRemoveItem = "api/Order/remove-item";

  static const String orderAutoLock = "api/Order/auto-lock";
  static const String orderLockNotification = "api/Order/lock-notification";
  static const String orderAutoCancel = "api/Order/auto-cancel";

  static const String rptOrderEstimate = "api/Report/order-estimate";
  
  
  static const String getHomeSliders = "api/HomeSlider/all";
  static const String saveHomeSlider = "api/HomeSlider/insertupdate";
  static const String changeHomeSliderStatus = "api/HomeSlider/change-status";
  static const String getAdvertisements = "api/Advertisement/all";
  static const String saveAdvertisement = "api/Advertisement/insertupdate";
  static const String changeAdvertisementStatus = "api/Advertisement/change-status";
  static const String getExpenseCategory = "api/ExpenseCategory/all";
  static const String saveExpenseCategory = "api/ExpenseCategory/insertupdate";
  static const String changeExpenseCategoryStatus = "api/ExpenseCategory/change-status";
  static const String getExpenses = "api/Expense/all";
  static const String saveExpense = "api/Expense/insertupdate";
  static const String changeExpenseStatus = "api/Expense/change-status";
  // ... List all API endpoints here
}
