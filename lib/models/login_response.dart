import 'common.dart';
import 'user_response.dart';

class LoginResponseModel {
  LoginData? data;
  Message? message;
  List<Message>? errors;

  String? status;
  bool? hasError;
  bool? hasInfo;

  LoginResponseModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? LoginData.fromJson(json['Data']) : null;
    message = json['Message'] != null
        ? Message.fromJson(json['Message'])
        : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class LoginData {
  TokenDetails? tokenDetails;
  User? user;

  LoginData({this.tokenDetails, this.user});

  LoginData.fromJson(Map<String, dynamic> json) {
    tokenDetails = json['TokenDetails'] != null
        ? TokenDetails.fromJson(json['TokenDetails'])
        : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tokenDetails != null) {
      data['TokenDetails'] = tokenDetails!.toJson();
    }
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}

class TokenDetails {
  String? token;
  String? notBefore;
  String? expires;

  TokenDetails({this.token, this.notBefore, this.expires});

  TokenDetails.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    notBefore = json['NotBefore'];
    expires = json['Expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['NotBefore'] = notBefore;
    data['Expires'] = expires;
    return data;
  }
}
