import '../data/api_list.dart';
import '../models/common.dart';
import '../models/order.dart';
import '../models/unlock_request.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceOrder {
  static Future<UnLockRequestModel> allUnLockRequests({int? status}) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getUnLockRequests,
      {
        "Filter": {"OrderStatus": status},
      },
    );
    var model = UnLockRequestModel.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatusUnLockRequests(
    int id,
    int action, {
    String? notes,
    int? customerId,
    int? orderId,
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeUnLockRequestStatus,
      {
        "Id": id,
        "Action": action,
        "Notes": notes ?? '',
        "RefID": customerId ?? 0,
        "OrderId": orderId ?? 0,
      },
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> orderCreate(
    int clusterMasterId,
    int customerId,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.orderCreate,
      {"ClusterMasterId": clusterMasterId, "CustomerId": customerId},
    );
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> addItem(
    int orderId,
    int productId,
    int productVarientId,
    String name,
    String varientName,
    String imagePath,
    int qty, {
    double discount = 0,
    double taxPercentage = 0,
    bool mergeIfExists = true,
  }) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.orderAddItem, {
          "OrderId": orderId,
          "ProductId": productId,
          "ProductVarientId": productVarientId,
          "Name": name,
          "VarientName": varientName,
          "ImagePath": imagePath,
          "Qty": qty,
          "Discount": discount,
          "TaxPercentage": taxPercentage,
          "MergeIfExists": mergeIfExists,
        });
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> modifyItem(
    int orderId,
    int itemId,
    int qty) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.orderUpdateItem, {
           "OrderId": orderId,
            "ItemId": itemId,
            "NewQty": qty
        });
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> removeItem(
    int orderId,
    int itemId,
    {bool removeAll = false}) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.orderRemoveItem, {
          "OrderId": orderId,
           "ItemId": itemId,
          "RemoveAll": removeAll
        });
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<OrdersModel> all(
    DateTime orderStartDate,
    DateTime orderEndDate, {
    int clusterMasterId = 1,
    int? customerId,
    int? active,
    int? orderStatus,
    int? paymentStatus,
    String searchString = '',
    bool? isLocked,
    int pNo = 1,
    int pSize = 200,
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getOrders,
      {
        "PageNo": pNo,
        "PageSize": pSize,
        "SortBy": 0,
        "SortOrder": 0,
        "Filter": {
          "ClusterMasterId": clusterMasterId,
          "CustomerId": customerId,
          "OrderStartDate": orderStartDate.toIso8601String(),
          "OrderEndDate": orderEndDate.toIso8601String(),
          "Active": active,
          "OrderStatus": orderStatus,
          "PaymentStatus": paymentStatus,
          "SearchString": searchString,
          "IsLocked": isLocked
        }
      },
    );
    var model = OrdersModel.fromJson(response!);
    return model;
  }

  static Future<OrderDetailModel> getOrderDetails(int orderId) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getOrderDetails,
      {
        "Id": orderId,
      },
    );
    var model = OrderDetailModel.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> orderChangeStatus(
    int id,
    int action, {
    String? notes,
    int? status
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeOrderStatus,
      {
        "Id": id,
        "Action": action,
        "Notes": notes ?? '',
        "Status": status ?? 0,
      },
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> orderAutoLock(
    DateTime orderDate) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.orderAutoLock, {
            "OrderDate": orderDate.toIso8601String()
        });
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

}
