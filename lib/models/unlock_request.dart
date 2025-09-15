import 'common.dart';

class UnLockRequestModel {
  UnLockRequestData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  UnLockRequestModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  UnLockRequestModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? UnLockRequestData.fromJson(json['Data']) : null;
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

class UnLockRequestData {
  List<UnLockRequest>? records;
  int? totalRecords;

  UnLockRequestData({this.records, this.totalRecords});

  UnLockRequestData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <UnLockRequest>[];
      json['Records'].forEach((v) {
        records!.add(UnLockRequest.fromJson(v));
      });
    }
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['Records'] = records!.map((v) => v.toJson()).toList();
    }
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class UnLockRequest {
  int? id;
  int? orderId;
  int? customerId;
  String? remarks;
  String? customerName;
  double? totalAmount;
  String? notes;
  String? createdDate;

  UnLockRequest(
      {this.id,
      this.orderId,
      this.customerId,
      this.remarks,
      this.customerName,
      this.totalAmount,
      this.notes,
      this.createdDate});

  UnLockRequest.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderId = json['OrderId'];
    customerId = json['CustomerId'];
    remarks = json['Remarks'];
    customerName = json['CustomerName'];
    totalAmount = (json['TotalAmount'] as num?)?.toDouble();
    notes = json['Notes'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['OrderId'] = orderId;
    data['CustomerId'] = customerId;
    data['Remarks'] = remarks;
    data['CustomerName'] = customerName;
    data['TotalAmount'] = totalAmount;
    data['Notes'] = notes;
    data['CreatedDate'] = createdDate;
    return data;
  }
}