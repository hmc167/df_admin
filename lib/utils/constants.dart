class AppConstants {
  static const String appName = "Dhanfuliya Fresh Admin";
  //static const String apiBaseUrl = "https://api.example.com/";
  static const String apiBaseUrl = "http://localhost:5000/";
  // ... other constants
}

const int WS_STATUSCODE_SUCCESS = 200;
const int WS_STATUSCODE_USERBLOCKED = -2;
const int WS_STATUSCODE_SESSION_EXPIRE = -3;
const int WS_STATUSCODE_USERNAME_PASSWORD_INVALID = -1;
const int WS_STATUSCODE_FAIL_ERROR = 0;

const int WS_STATUSCODE_BAD_REQUEST_400 = 400;
const int WS_STATUSCODE_UNAUTHORIZED_401 = 401;
const int WS_STATUSCODE_FORBIDDEN_403 = 403;
const int WS_STATUSCODE_NOT_FOUND_404 = 404;
const int WS_STATUSCODE_UNPROCESSABLE_422 = 422;
const int WS_STATUSCODE_INTERNAL_SERVER_ERROR_500 = 500;
const String ApiStatus = "status";
const String HTTP_POST = "post";
const String HTTP_GET = "get";
const String HTTP_DELETE = "delete";
const String HTTP_PATCH = "patch";
const String HTTP_PUT = "put";
