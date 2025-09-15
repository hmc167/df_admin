
import '../data/api_list.dart';
import '../models/common.dart';
import '../models/unlock_request.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceOrder {
  static Future<UnLockRequestModel> allUnLockRequests({
    int? status,
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getUnLockRequests,
      {
         "Filter": {
           "OrderStatus": status
         }
      },
    );
    var model = UnLockRequestModel.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatusUnLockRequests(int id, int action,{
    String? notes, int? customerId, int? orderId
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeUnLockRequestStatus,
      {
        "Id": id,
        "Action": action,
        "Notes":notes??'',
        "RefID":customerId??0,
        "OrderId":orderId??0
      },
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

}
