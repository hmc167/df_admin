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

  // ... List all API endpoints here
}
