import '../data/api_list.dart';
import '../models/login_response.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceLogin {
  static Future<LoginResponseModel> login(
    String username,
    String password,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.login,
      {'Mobile': username, 'Password': password},
      isAuthentication: false,
      checkRefreshToken: false,
    );
    var model = LoginResponseModel.fromJson(response!);
    return model;
  }
}
