import '../data/api_list.dart';
import '../models/login_response.dart';
import '../utils/constants.dart';
import 'storage_service.dart';
import 'web_service_client.dart';

class ApiService {
  static Future<LoginResponseModel> login(
    String username,
    String password,
  ) async {
    final response = await webServiceClientAPI(HTTP_POST, ApiList.login, {
      'Mobile': username,
      'Password': password,
    });
    print(response);
    var model = LoginResponseModel.fromJson(response!);
    return model;
  }
}
