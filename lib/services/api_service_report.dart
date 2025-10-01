import '../data/api_list.dart';
import '../models/order.dart';
import '../models/report_order_estimate.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceReport {
  static Future<OrderEstimateModel> orderEstimate(
    DateTime orderDate, bool onlyItemDetails, bool includeUnLockItem) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.rptOrderEstimate,
      {
        "OrderDate": orderDate.toIso8601String(),
        "OnlyItemDetails": onlyItemDetails,
        "IncludeUnLockItem": includeUnLockItem,
      },
    );
    var model = OrderEstimateModel.fromJson(response!);
    return model;
  }

  static Future<OrdersModel> allOrders(
    DateTime orderStartDate,
    DateTime orderEndDate, {
    int clusterMasterId = 1,
    int? customerId,
    int? active,
    int? orderStatus,
    int? paymentStatus,
    int? deliverySlotId,
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
          "IsLocked": isLocked,
          "DeliverySlotId": deliverySlotId,
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

  

}
