import 'common.dart';

class OrderEstimateModel {
  OrderEstimateData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  OrderEstimateModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  OrderEstimateModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? OrderEstimateData.fromJson(json['Data']) : null;
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

class OrderEstimateData {
  List<OrderEstimate>? records;
  int? totalRecords;
  String? reportString;

  OrderEstimateData({this.records, this.totalRecords, this.reportString});

  OrderEstimateData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <OrderEstimate>[];
      json['Records'].forEach((v) {
        records!.add(OrderEstimate.fromJson(v));
      });
    }
    totalRecords = json['TotalRecords'];
    reportString = json['ReportString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['Records'] = records!.map((v) => v.toJson()).toList();
    }
    data['TotalRecords'] = totalRecords;
    data['ReportString'] = reportString;
    return data;
  }
}

class OrderEstimate {
  int? productId;
  String? name;
  double? total;
  String? unitCategoryName;
  List<OrderItemEstimates>? orderItemEstimates;

  OrderEstimate(
      {this.productId,
      this.name,
      this.total,
      this.unitCategoryName,
      this.orderItemEstimates});

  OrderEstimate.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    name = json['Name'];
    total = (json['Total'] as num?)?.toDouble();
    unitCategoryName = json['UnitCategoryName'];
    if (json['OrderItemEstimates'] != null) {
      orderItemEstimates = <OrderItemEstimates>[];
      json['OrderItemEstimates'].forEach((v) {
        orderItemEstimates!.add(OrderItemEstimates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductId'] = productId;
    data['Name'] = name;
    data['Total'] = total;
    data['UnitCategoryName'] = unitCategoryName;
    if (orderItemEstimates != null) {
      data['OrderItemEstimates'] =
          orderItemEstimates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemEstimates {
  int? productVarientId;
  String? varientName;
  int? qty;
  double? unitValue;
  String? unitName;
  double? multiplier;
  double? unitTotal;

  OrderItemEstimates(
      {this.productVarientId,
      this.varientName,
      this.qty,
      this.unitValue,
      this.unitName,
      this.multiplier,
      this.unitTotal});

  OrderItemEstimates.fromJson(Map<String, dynamic> json) {
    productVarientId = json['ProductVarientId'];
    varientName = json['VarientName'];
    qty = json['Qty'];
    unitValue = (json['UnitValue'] as num?)?.toDouble();
    unitName = json['UnitName'];
    multiplier = (json['Multiplier'] as num?)?.toDouble();
    unitTotal = (json['UnitTotal'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductVarientId'] = productVarientId;
    data['VarientName'] = varientName;
    data['Qty'] = qty;
    data['UnitValue'] = unitValue;
    data['UnitName'] = unitName;
    data['Multiplier'] = multiplier;
    data['UnitTotal'] = unitTotal;
    return data;
  }
}