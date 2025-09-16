import '../data/api_list.dart';
import '../models/report_order_estimate.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceReport {
  static Future<OrderEstimateModel> orderEstimate(
    DateTime orderDate, bool onlyItemDetails) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.rptOrderEstimate,
      {
        "OrderDate": orderDate.toIso8601String(),
        "OnlyItemDetails": onlyItemDetails,
      },
    );
    var model = OrderEstimateModel.fromJson(response!);
    return model;
  }

  

}
