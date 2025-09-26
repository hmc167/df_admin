import 'package:admin/models/customer_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cluster_master.dart';
import '../models/customer_balance_history.dart';
import '../models/customer_model.dart';
import '../models/delivery_slots.dart';
import '../services/api_service_customer_master.dart';
import '../utils/helpers.dart';
import '../widgets/customer_add_edit_popup.dart';
import '../widgets/customer_balance_account_popup.dart';
import '../widgets/customer_address_popup.dart';

class CustomersController extends GetxController {
  final filterNameController = TextEditingController();
  final filterClusterId = 0.obs;
  final filterStatus = 0.obs;
  final filterApproved = 0.obs;  
  final filterTodayOnly = false.obs;

  final nameFocusNode = FocusNode();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final totalRecords = 0.obs;

  RxList<CustomerMaster> customers = <CustomerMaster>[].obs;
  RxList<BalanceHistory> balanceHistory = <BalanceHistory>[].obs;
  RxList<CustomerAddress> addresses = <CustomerAddress>[].obs;
  RxList<ClusterMaster> clusters = <ClusterMaster>[].obs;
  RxList<DeliverySlots> deliverySlots = <DeliverySlots>[].obs;

  @override
  void onInit() {
    super.onInit();
    bindClusters();
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  void loadData() {
    getCustomers();
  }

  Future<void> searchCustomers() async {
    await getCustomers();
    String text = filterNameController.text;
    int value = filterClusterId.value;
    int sts = filterStatus.value;
    int stsApproved = filterApproved.value;
    List<CustomerMaster> filtered = customers.where((customer) {
      final matchesName =
          text.isEmpty ||
          (customer.firstName?.toLowerCase().contains(text.toLowerCase()) ??
              false) ||
          (customer.lastName?.toLowerCase().contains(text.toLowerCase()) ??
              false) ||
          (customer.mobile?.toLowerCase().contains(text.toLowerCase()) ??
              false);
      final matchesParent = value == 0 || customer.clusterMasterId == value;
      final matchesStatus =
          sts == 0 ||
          (sts == 1 ? customer.isActive == true : customer.isActive == false);
      final matchesApproved =
          stsApproved == 0 ||
          (stsApproved == 1
              ? customer.isApproved == true
              : customer.isApproved == false);
      return matchesName && matchesParent && matchesStatus && matchesApproved;
    }).toList();
    customers.value = filtered;
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    filterClusterId.value = 0;
    filterStatus.value = 0;
    filterApproved.value = 0;
    filterTodayOnly.value = false;
    await searchCustomers();
  }

  Future<void> openAddEditPopup(CustomerMaster customerMaster) async {
    Helpers.showPopup(
      CustomerAddEditPopup(customerMaster: customerMaster, controller: this),
      width: 900,
      height: 500,
    );
  }

  void deleteCustomer(CustomerMaster customer) {}

  Future<void> openBalanceAccountPopup(CustomerMaster customer) async {
    await bindBalanceHistory(customer.id ?? 0);
    Helpers.showPopup(
      CustomerBalanceAccountPopup(customerMaster: customer, controller: this),
      width: 900,
      height: 600,
    );
  }

  Future<void> bindBalanceHistory(int customerId) async {
    var result = await ApiServiceCustomerMaster.balanceHistory(customerId);
    if (result.hasError == false) {
      balanceHistory.value = result.data?.records ?? [];
    } else {
      balanceHistory.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching balance history',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getCustomers() async {
    isLoading.value = true;
    bool? todayOnly;
    if(filterTodayOnly.value == true){
      todayOnly = true;
    }
    try {
      var result = await ApiServiceCustomerMaster.all(
        filterNameController.text,
        clusterMasterId: filterClusterId.value,
        active: filterStatus.value,
        approved: filterApproved.value,
        pNo: 1,
        pSize: 100,
        todayOnly: todayOnly
      );
      if (result.hasError == false) {
        errorMessage.value = '';
        var dbCustomers = result.data?.records ?? [];
        totalRecords.value = result.data?.totalRecords ?? 0;
        customers.value = dbCustomers;
      } else {
        errorMessage.value =
            result.errors?.firstOrNull?.message ?? 'No record found';
      }
    } catch (e) {
      errorMessage.value = 'Failed to load customers';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bindAddress(int customerId) async {
    var result = await ApiServiceCustomerMaster.allAddress(customerId);
    if (result.hasError == false) {
      addresses.value = result.data?.records ?? [];
    } else {
      addresses.value = [];
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error fetching address',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> openAddressPopup(CustomerMaster customer) async {
    await bindAddress(customer.id ?? 0);
    Helpers.showPopup(
      CustomerAddressPopup(customerMaster: customer, controller: this),
      width: 900,
      height: 500,
    );
  }

  Future<bool> save(CustomerMaster customer) async {
    final result = await ApiServiceCustomerMaster.save(customer);
    if (result.hasError == false) {
      await getCustomers();
      return true;
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error saving customer',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      return false;
    }
  }

  Future<bool> addBalance(
    CustomerMaster customer,
    double amount,
    String remarks,
    int paymentMode,
  ) async {
    var result = await ApiServiceCustomerMaster.addBalance(
      customer.id ?? 0,
      amount,
      remarks,
      paymentMode
    );
    if (result.hasError == false) {
      Get.snackbar(
        'Success',
        'Balance added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      bindBalanceHistory(customer.id ?? 0);
      await getCustomers();
      return true;
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error adding balance',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
    return false;
  }

  Future<bool> saveCustomerAddress(
    int customerID,
    CustomerAddress cAddress,
  ) async {
    var result = await ApiServiceCustomerMaster.saveCustomerAddress(
      cAddress,
      customerID,
    );
    if (result.hasError == false) {
      Get.back();
      Get.snackbar(
        'Success',
        'Customer address saved successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      return true;
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error saving customer address',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      return false;
    }
  }

  Future<void> bindClusters() async {
    var result = await ApiServiceCustomerMaster.allClusterMasters();
    if (result.hasError == false) {
      clusters.value = result.data?.records ?? [];
      await bindDeliverySlots(clusters.firstOrNull?.iD??1);
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

  Future<void> bindDeliverySlots(int clusterID) async {
    var result = await ApiServiceCustomerMaster.allSlots(clusterID);
    if (result.hasError == false) {
      deliverySlots.value = result.data?.records ?? [];
    } else {
      deliverySlots.value = [];
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

  getPaymentModeText(int? paymentMode) {
    switch (paymentMode) {
      case 0:
        return 'Cash';
      case 1:
        return 'Online';
      case 2:
        return 'Wallet';
      case 3:
        return 'Other';
      default:
        return 'Unknown';
    }
  }

  void approveCustomer(CustomerMaster customer) async {
    var result = await ApiServiceCustomerMaster.changeStatus(customer, 4, 0);
    if (result.hasError == false) {
      Get.snackbar(
        'Success',
        'Customer approved successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      await getCustomers();
    } else {
      Get.snackbar(
        'Error',
        result.errors?.firstOrNull?.message ?? 'Error approving customer',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

}
