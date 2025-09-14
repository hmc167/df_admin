import 'common.dart';

class DashboardDataModel {
  DashboardData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  DashboardDataModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? DashboardData.fromJson(json['Data']) : null;
    message =
        json['Message'] != null ? Message.fromJson(json['Message']) : null;
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

class DashboardData {
  int? totalOrder;
  int? lockOrder;
  int? totalCategory;
  int? totalProduct;
  int? totalProductActive;
  int? totalProductInActive;
  int? totalCustomer;
  int? totalTodayCustomer;
  int? totalCustomerApproved;
  int? totalCustomerPending;
  int? totalCustomerInquiry;

  DashboardData(
      {this.totalOrder,
      this.lockOrder,
      this.totalCategory,
      this.totalProduct,
      this.totalProductActive,
      this.totalProductInActive,
      this.totalCustomer,
      this.totalTodayCustomer,
      this.totalCustomerApproved,
      this.totalCustomerPending,
      this.totalCustomerInquiry});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalOrder = json['TotalOrder'];
    lockOrder = json['LockOrder'];
    totalCategory = json['TotalCategory'];
    totalProduct = json['TotalProduct'];
    totalProductActive = json['TotalProductActive'];
    totalProductInActive = json['TotalProductInActive'];
    totalCustomer = json['TotalCustomer'];
    totalTodayCustomer = json['TotalTodayCustomer'];
    totalCustomerApproved = json['TotalCustomerApproved'];
    totalCustomerPending = json['TotalCustomerPending'];
    totalCustomerInquiry = json['TotalCustomerInquiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalOrder'] = totalOrder;
    data['LockOrder'] = lockOrder;
    data['TotalCategory'] = totalCategory;
    data['TotalProduct'] = totalProduct;
    data['TotalProductActive'] = totalProductActive;
    data['TotalProductInActive'] = totalProductInActive;
    data['TotalCustomer'] = totalCustomer;
    data['TotalTodayCustomer'] = totalTodayCustomer;
    data['TotalCustomerApproved'] = totalCustomerApproved;
    data['TotalCustomerPending'] = totalCustomerPending;
    data['TotalCustomerInquiry'] = totalCustomerInquiry;
    return data;
  }
}