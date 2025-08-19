import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admin/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future<Map<String, dynamic>?> webServiceClientAPI(
  String methodType,
  String url,
  Map? map, {
  isAuthentication = true,
  addDeviceinfo = true,
  checkRefreshToken = true,
}) async {
  var header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    //'Content-Type': 'application/x-www-form-urlencoded'
  };

  try {
    if (isAuthentication == true) {
      var token = StorageService.getToken();

      header = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        //'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      };
    }
  } catch (e, s) {
    if (kDebugMode) {
      print("$e\n$s");
    }
  }

  final myUri = Uri.parse('${AppConstants.apiBaseUrl}$url');
  http.Response? response;
  Map? mapExtra = {};
  mapExtra['Device'] = 1;
  mapExtra['DeviceVersion'] = "1.0";
  if (addDeviceinfo) {
    if (Platform.isWindows) {
      mapExtra['DeviceID'] = Platform.localHostname as Object;
      mapExtra['DeviceName'] = Platform.operatingSystem as Object;
    }
  }
  map?.addAll(mapExtra);
  Map<String, dynamic>? responseBody;
  try {
    if (methodType == HTTP_POST) {
      response = await http.post(
        myUri,
        headers: header,
        body: jsonEncode(
          map,
          toEncodable: (Object? value) =>
              value is DateTime ? (value.toString()) : null,
        ),
      );
    } else if (methodType == "get") {
      //print("APIRequest", url.toString());
      response = await http.get(myUri, headers: header);
    } else if (methodType == HTTP_DELETE) {
      //print("APIRequest", url.toString());
      response = await http.delete(myUri, headers: header);
    } else if (methodType == HTTP_PATCH) {
      //print("APIRequest", map!.entries.toList().toString());
      response = await http.patch(myUri, headers: header, body: map);
    }

    try {
      if (response!.statusCode == 200) {
        responseBody = json.decode(response.body);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("$e\n$s");
      }
    }

    var statusCode = response!.statusCode;

    if (statusCode == WS_STATUSCODE_UNAUTHORIZED_401) {
      //
    } else {
      responseBody ??= json.decode(
        '{"success":false,"errors":[{"type":"Error","message":"An error occured: [Status code : $statusCode]."}],"status":"$statusCode"}',
      );
    }
  } on TimeoutException catch (e, s) {
    if (kDebugMode) {
      print("$e\n$s");
    }
    if (methodType == "GET" && isAuthentication == false) {
      // this condition is for choose network GET api cll (API_ESP_SCAN,API_ESP_DEVICE_INFO,API_ESP_DEVICE_STATE)
      responseBody = json.decode(
        '{"Success":false,"Message":"Timeout occur. Please try again later.","Status":"422"}',
      );
    } else {
      responseBody = json.decode(
        '{"success":false,"errors":[{"type":"Error","message":"Timeout occur. Please try again later."}],"status":"422"}',
      );
    }
  } on Error catch (e) {
    if (kDebugMode) {
      print("$e");
    }
  } on SocketException catch (e) {
    if (kDebugMode) {
      print('SocketExceptionError: $e');
    }

    responseBody = json.decode(
      '{"success":false,"message":"Maintenance in progress. Please try again in few minutes.","Status":"422"}',
    );
  } on HandshakeException catch (e) {
    if (kDebugMode) {
      print('HandshakeException: $e');
    }
    responseBody = json.decode(
      '{"success":false,"message":"Handshake Sever error. Please try again later.","Status":"422"}',
    );
  }

  return responseBody;
}

// check whether is there any error in web response
bool isErrorInWebResponse(int statusCode) {
  // Handler handler = new Handler();
  bool isError = true;
  // bool isUnauthorized = false;

  switch (statusCode) {
    case WS_STATUSCODE_SUCCESS:
      isError = false;
      break;
    case WS_STATUSCODE_UNAUTHORIZED_401:
      // isUnauthorized = true;
      break;
    case WS_STATUSCODE_FAIL_ERROR:
    case WS_STATUSCODE_SESSION_EXPIRE:
    case WS_STATUSCODE_BAD_REQUEST_400:
    case WS_STATUSCODE_INTERNAL_SERVER_ERROR_500:
    case WS_STATUSCODE_FORBIDDEN_403:
    case WS_STATUSCODE_NOT_FOUND_404:
    case WS_STATUSCODE_UNPROCESSABLE_422:
      isError = true;
      break;
  }
  return isError;
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
