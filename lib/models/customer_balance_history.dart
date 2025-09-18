import 'common.dart';

class BalanceHistoryModel {
  BalanceHistoryData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  BalanceHistoryModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  BalanceHistoryModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? BalanceHistoryData.fromJson(json['Data']) : null;
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

class BalanceHistoryData {
  List<BalanceHistory>? records;
  int? totalRecords;

  BalanceHistoryData({this.records, this.totalRecords});

  BalanceHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <BalanceHistory>[];
      json['Records'].forEach((v) {
        records!.add(BalanceHistory.fromJson(v));
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

class BalanceHistory {
  int? id;
  double? transactionBalance;
  double? newBalance;
  int? transactionType;
  int? paymentMode;
  String? createdDate;
  String? remarks;
  int? totalRecords;

  BalanceHistory(
      {this.id,
      this.transactionBalance,
      this.newBalance,
      this.transactionType,
      this.paymentMode,
      this.createdDate,
      this.remarks,
      this.totalRecords});

  BalanceHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    transactionBalance = (json["TransactionBalance"] as num?)?.toDouble();
    newBalance = (json["NewBalance"] as num?)?.toDouble();
    transactionType = json['TransactionType'];
    paymentMode = json['PaymentMode'];
    createdDate = json['CreatedDate'];
    remarks = json['Remarks'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['TransactionBalance'] = transactionBalance;
    data['NewBalance'] = newBalance;
    data['TransactionType'] = transactionType;
    data['PaymentMode'] = paymentMode;
    data['CreatedDate'] = createdDate;
    data['Remarks'] = remarks;
    data['TotalRecords'] = totalRecords;
    return data;
  }
}