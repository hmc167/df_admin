import 'package:admin/models/customer_balance_history.dart';

import '../data/api_list.dart';
import '../models/cluster_master.dart';
import '../models/common.dart';
import '../models/customer_address.dart';
import '../models/customer_model.dart';
import '../models/delivery_slots.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceCustomerMaster {
  static Future<CustomerMasterModel> all(
    String searchString, {
    int clusterMasterId = 0,
    int active = 0,
    int approved = 0,
    int pNo = 1,
    int pSize = 20,
    bool? todayOnly,
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getAllCustomer,
      {
        "PageNo": pNo,
        "PageSize": pSize,
        "SortBy": 0,
        "SortOrder": 0,
        "Filter": {
          "Approved": approved,
          "Active": active,
          "SearchText": searchString,
          "ClusterMasterId": clusterMasterId,
          "TodayOnly": todayOnly,
        },
      },
    );
    var model = CustomerMasterModel.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> save(CustomerMaster customer) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveCustomer, {
          'CustomerID': customer.id ?? 0,
          'ClusterMasterId': customer.clusterMasterId ?? 1,
          'FirstName': customer.firstName,
          'LastName': customer.lastName,
          'Mobile': customer.mobile,
          'IsActive': customer.isActive,
          'IsApproved': customer.isApproved,
          'AllowLimit': customer.allowLimit,
          'CallBeforeDelivery': customer.callBeforeDelivery,
          'RingTheBell': customer.ringTheBell,
          'DeliverySlotID': customer.deliverySlotId,
        });
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatus(
    CustomerMaster customer,
    int action,
    int refID,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeCustomerStatus,
      {'ID': customer.id, 'Action': action, "RefID": refID},
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<CustomerAddressModel> allAddress(int id) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getAllCustomerAddress,
      {'Id': id},
    );
    var model = CustomerAddressModel.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> saveCustomerAddress(
    CustomerAddress ca,
    int customerID,
  ) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveCustomerAddress, {
          'Id': ca.id,
          'CustomerID': customerID,
          'BuildingNameNumber': ca.buildingNameNumber,
          'Address1': ca.address1,
          'Address2': ca.address2,
          'VillageORTown': ca.villageORTown,
          'VillageORTownId': ca.villageORTownId ?? 0,
          'Taluka': ca.taluka,
          'TalukaId': ca.talukaId ?? 0,
          'District': ca.district,
          'DistrictId': ca.districtId ?? 0,
          'State': ca.state,
          'StateId': ca.stateId ?? 0,
          'PinCode': ca.pinCode,
          'Latitude': ca.latitude ?? 0.0,
          'Longitude': ca.longitude ?? 0.0,
          'Type': ca.type,
          'IsDefault': ca.isDefault,
        });
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> addBalance(
    int custID,
    double amount,
    String remarks,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.addCustomerBalance,
      {'ID': custID, 'Balance': amount, 'Remark': remarks},
    );
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<BalanceHistoryModel> balanceHistory(
    int custID, {
    int action = 0,
    int pNo = 1,
    int pSize = 20,
    int? month,
    int? year,
  }) async {
    month ??= DateTime.now().month;
    year ??= DateTime.now().year;
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getCustomerBalanceHistory,
      {
        "ID": custID,
        "Action": action,
        "PageNo": pNo,
        "PageSize": pSize,
        "Filter": {"Month": month, "Year": year},
      },
    );
    var model = BalanceHistoryModel.fromJson(response!);
    return model;
  }

  static Future<DeliverySlotsModel> allSlots(int id) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getDeliverySlots,
      {
        "Filter": {"Id": id, "Active": 1, "SearchString": ""},
      },
    );
    var model = DeliverySlotsModel.fromJson(response!);
    return model;
  }

  static Future<ClusterMasterModel> allClusterMasters() async {
    final response = await webServiceClientAPI(HTTP_POST, ApiList.getClusters, {
        "Filter": {"Id": 0, "Active": 1, "SearchString": ""},
      });
    var model = ClusterMasterModel.fromJson(response!);
    return model;
  }
}
