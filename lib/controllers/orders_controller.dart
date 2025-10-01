import 'package:admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/category_master.dart';
import '../models/cluster_master.dart';
import '../models/customer_model.dart';
import '../models/delivery_slots.dart';
import '../models/order.dart';
import '../models/product_search.dart';
import '../services/api_service_category_master.dart';
import '../services/api_service_customer_master.dart';
import '../services/api_service_order.dart';
import '../services/api_service_product_master.dart';
import '../utils/helpers.dart';
import '../widgets/order_details_popup.dart';
import '../widgets/add_item_popup.dart';
import '../widgets/order_status_history_popup.dart';

class OrdersController extends GetxController {
   RxBool isLockingOrder = false.obs;
   RxBool isCancellingOrder = false.obs;
   RxBool isNotifyingLockOrder = false.obs;
  var isLoading = false.obs;

  final filterNameController = TextEditingController();
  final filterStartDateController = TextEditingController();
  final filterEndDateController = TextEditingController();
  final customerSearchController = TextEditingController();

  final filterOnlyLock = false.obs;
  final filterCategoryId = 0.obs;
  final RxInt filterStatus = (-1).obs;
  final RxInt filterPaymentStatus = (-1).obs;
  final filterCustomerId = 0.obs;
  final RxnInt filterClusterId = RxnInt();
  Rxn<DateTime> filterStartDate = Rxn<DateTime>();
  Rxn<DateTime> filterEndDate = Rxn<DateTime>();

  final nameFocusNode = FocusNode();
  RxList<CategoryMaster> productCategories = <CategoryMaster>[].obs;
  RxList<ClusterMaster> clusters = <ClusterMaster>[].obs;
  RxList<CustomerInfo> customers = <CustomerInfo>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Order> orders = <Order>[].obs;
  RxList<DeliverySlots> deliverySlots = <DeliverySlots>[].obs;
  Rxn<OrderDetailData> selectedOrder = Rxn<OrderDetailData>();
  
  final RxInt selectedProduct = 0.obs;
  final RxInt selectedVariant = 0.obs;
  @override
  void onInit() {
    super.onInit();
    bindCategories();
    bindClusters();
    filterStartDate.value = DateTime.now();
    filterStartDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    filterEndDate.value = DateTime.now();
    filterEndDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  Future<void> search() async {
    await getOrders();
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    filterOnlyLock.value = false;
    filterStatus.value = -1;
    filterPaymentStatus.value = -1;
    filterCustomerId.value = 0;
    customers.clear();
    products.clear();
    filterStartDate.value = DateTime.now();
    filterStartDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    filterEndDate.value = DateTime.now();
    filterEndDateController.text =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    await getOrders();
  }

  Future<void> openAddPopup(int orderId) async {
    var orderDetails = OrderDetailModel();
    if (orderId > 0) {
      orderDetails = await ApiServiceOrder.getOrderDetails(orderId);
      if (orderDetails.hasError == true) {
        Get.snackbar(
          'Error',
          orderDetails.errors?.firstOrNull?.message ??
              'Error loading order details',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
    }
    else{
      
    }
    selectedOrder.value = orderDetails.data;
    await Helpers.showPopup(OrderDetailsPopup(controller: this), width: 900);
    await getOrders();
  }

  Future<void> bindCategories() async {
    final result = await ApiServiceCategoryMaster.all();
    if (result.hasError == false) {
      var dbCategories = result.data?.records ?? [];
      if (dbCategories.isNotEmpty) {
        var pCats = [
          CategoryMaster(
            iD: 0,
            name: 'Select Category',
            parentCategoryMasterId: null,
            isActive: true,
          ),
        ];
        pCats.addAll(dbCategories.where((c) => (c.isActive ?? false)).toList());
        productCategories.value = pCats;
      }
    }
  }

  Future<void> bindClusters() async {
    var result = await ApiServiceCustomerMaster.allClusterMasters();
    if (result.hasError == false) {
      clusters.value = result.data?.records ?? [];
      filterClusterId.value = clusters.firstOrNull?.iD ?? 1;      
    } else {
      clusters.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching clusters',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getProducts(int categoryId) async {
    final result = await ApiServiceProductMaster.allSearch(
      categoryId,
      clusterId: clusters.firstOrNull?.iD ?? 0,
    );
    if (result.hasError == false) {
      var dbProducts = result.data?.records ?? [];
      if (dbProducts.isNotEmpty) {
        products.value = dbProducts;
      }
      else{
        products.value = [];
      }
    } else {
      products.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching products',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getOrders() async {
    final result = await ApiServiceOrder.all(
      DateTime(
        filterStartDate.value?.year ?? 2025,
        filterStartDate.value?.month ?? 1,
        filterStartDate.value?.day ?? 1,
        0,
        0,
        0,
      ),
      DateTime(
        filterEndDate.value?.year ?? 2025,
        filterEndDate.value?.month ?? 1,
        filterEndDate.value?.day ?? 1,
        23,
        59,
        59,
      ),
      orderStatus: (filterStatus.value > -1) ? filterStatus.value : null,
      paymentStatus: (filterPaymentStatus.value > -1)
          ? filterPaymentStatus.value
          : null,
      customerId: (filterCustomerId.value > 0) ? filterCustomerId.value : null,
      clusterMasterId: filterClusterId.value??1,
      isLocked: filterOnlyLock.value ? true : null,
      searchString: filterNameController.text.trim(),
    );
    if (result.hasError == false) {
      var dbOrders = result.data?.records ?? [];
      if (dbOrders.isNotEmpty) {
        orders.value = dbOrders;
      }
      else{
        orders.value = [];
      }
    } else {
      orders.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching orders',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<List<CustomerInfo>> fetchCustomers(String text) async {
    if (text.isEmpty) {
      return [];
    }
    final result = await ApiServiceCustomerMaster.search(text);
    if (result.hasError == false) {
      return result.data?.records ?? [];
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching customers',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      return [];
    }
  }

  String getOrderStatusText(int? orderStatus) {
    switch (orderStatus) {
      case 0:
        return 'Pending (New)';
      case 1:
        return 'Confirmed';
      case 2:
        return 'ReadyToShip';
      case 3:
        return 'OutForDelivery';
      case 4:
        return 'Delivered';
      case 5:
        return 'Cancelled';
      case 6:
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  String getPaymentStatusText(int? paymentStatus) {
    switch (paymentStatus) {
      case 0:
        return 'Pending';
      case 1:
        return 'Paid';
      case 2:
        return 'PartiallyPaid';
      case 3:
        return 'Failed';
      case 4:
        return 'Cancelled';
      case 5:
        return 'Refunded';
      default:
        return 'Unknown';
    }
  }

  void createOrder(int customerId) async {
    isLoading.value = true;
    var result = await ApiServiceOrder.orderCreate(
      clusters.firstOrNull?.iD ?? 1,
      customerId,
    );
    isLoading.value = false;
    if (result.hasError == false) {
      var orderId = result.data ?? 0;
      if (orderId == 0) {
        return;
      }
      var orderDetails = await ApiServiceOrder.getOrderDetails(orderId);
      if (orderDetails.hasError == true) {
        Get.snackbar(
          'Error',
          orderDetails.errors?.firstOrNull?.message ??
              'Error loading order details',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
      selectedOrder.value = orderDetails.data;
    } else {
      Get.snackbar(
        'Error',
        result.message?.message ?? result.errors?.firstOrNull?.message ?? 'Error creating order',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> showAddItemDialog(BuildContext context) async {
    await Helpers.showPopup(AddItemPopup(controller: this), width: 900);
  }

  Future<void> addItemToOrder(Product product, ProductSearchVariants? productSearchVariants, int quantity) async {
    var result = await ApiServiceOrder.addItem(
      selectedOrder.value?.id ?? 0,
      product.id ?? 0,
      productSearchVariants?.id ?? 0,
      product.name ?? '',
      productSearchVariants?.name ?? '',
      product.imagePath ?? '',
      quantity,
    );
    if(result.hasError == false){
      var orderDetails = await ApiServiceOrder.getOrderDetails(selectedOrder.value?.id ?? 0);
      if (orderDetails.hasError == true) {
        Get.snackbar(
          'Error',
          orderDetails.errors?.firstOrNull?.message ??
              'Error loading order details',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
      selectedOrder.value = orderDetails.data;
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error adding item to order',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  void removeItem(int orderID, int itemID) async {
    var result = await ApiServiceOrder.removeItem(
      orderID,
      itemID,
      removeAll: false,
    );
    if(result.hasError == false){
      var orderDetails = await ApiServiceOrder.getOrderDetails(selectedOrder.value?.id ?? 0);
      if (orderDetails.hasError == true) {
        Get.snackbar(
          'Error',
          orderDetails.errors?.firstOrNull?.message ??
              'Error loading order details',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
      selectedOrder.value = orderDetails.data;
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error removing item from order',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }
  
  Future<bool> modifyItem(int orderID, int itemID, int qty) async {
    var result = await ApiServiceOrder.modifyItem(
      orderID,
      itemID,
      qty,
    );
    if(result.hasError == false){
        var orderDetails = await ApiServiceOrder.getOrderDetails(selectedOrder.value?.id ?? 0);
        if (orderDetails.hasError == true) {
          Get.snackbar(
            'Error',
            orderDetails.errors?.firstOrNull?.message ??
                'Error loading order details',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(10),
          );
          return false;
        }
        selectedOrder.value = orderDetails.data;
        return true;
      } else {
        Get.snackbar(
          'Error',
          result.errors?.firstOrNull?.message ?? 'Error modifying item in order',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return false;
      }
  }

  Future<void> orderStatusHistory() async {
    await Helpers.showPopup(OrderStatusHistoryPopup(controller: this), width: 600);
  }

  Future<void> lockAllOrders() async {
    bool confirmed = await Helpers.showConfirmationDialog(
      title: 'Lock Orders',
      message: 'Are you sure you want to lock all orders?',
    );
    if (!confirmed) return;
    isLockingOrder.value = true;
    var result = await ApiServiceOrder.orderAutoLock(DateTime.now());
    isLockingOrder.value = false;
    if(result.hasError == false){
      await getOrders();
      Get.snackbar(
        'Success',
        'All orders locked successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error locking orders',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> changeStatus(Order order) async {

  var oldSStatus = order.orderStatus ?? 0;
  var newStatus = (order.orderStatus ?? 0) + 1;

    bool confirmed = await Helpers.showConfirmationDialog(
      title: 'Change Order Status',
      message: 'Are you sure you want to change the status ( ${getOrderStatusText(oldSStatus)} ) to ${getOrderStatusText(newStatus)} of this order?',
    );
    if (!confirmed) return;
    var result = await ApiServiceOrder.orderChangeStatus(
      order.id ?? 0,
      ChangeStatusAction.changeStatus,
      status:newStatus,
    );
    if(result.hasError == false && result.data == true){
      await getOrders();
      Get.snackbar(
        'Success',
        'Order status changed successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error changing order status',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> sendLockNotification() async {
      bool confirmed = await Helpers.showConfirmationDialog(
      title: 'Lock Notification',
      message: 'Are you sure you want to send notifications for all orders?',
    );
    if (!confirmed) return;
    isNotifyingLockOrder.value = true;
    var result = await ApiServiceOrder.lockNotification(DateTime.now());
    isNotifyingLockOrder.value = false;
    if(result.hasError == false){
      await getOrders();
      Get.snackbar(
        'Success',
        'Notifications sent successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error sending notifications',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> orderAutoCancel() async {
    bool confirmed = await Helpers.showConfirmationDialog(
      title: 'Auto Cancel Orders',
      message: 'Are you sure you want to cancel all unlocked orders?',
    );
    if (!confirmed) return;
    isCancellingOrder.value = true;
    var result = await ApiServiceOrder.orderAutoCancel(DateTime.now());
    isCancellingOrder.value = false;
    if(result.hasError == false){
      await getOrders();
      Get.snackbar(
        'Success',
        'Unlock orders canceled successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error canceling orders',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }
  
}
