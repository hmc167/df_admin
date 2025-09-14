import 'common.dart';

class DeliverySlotsModel {
  DeliverySlotsData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  DeliverySlotsModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  DeliverySlotsModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? DeliverySlotsData.fromJson(json['Data'])
        : null;
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

class DeliverySlotsData {
  List<DeliverySlots>? records;
  int? totalRecords;

  DeliverySlotsData({this.records, this.totalRecords});

  DeliverySlotsData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <DeliverySlots>[];
      json['Records'].forEach((v) {
        records!.add(DeliverySlots.fromJson(v));
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

class DeliverySlots {
  int? iD;
  String? name;
  String? clusterMasterName;
  int? clusterMasterId;
  bool? isActive;

  DeliverySlots({
    this.iD,
    this.name,
    this.clusterMasterName,
    this.clusterMasterId,
    this.isActive,
  });

  DeliverySlots.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    clusterMasterName = json['ClusterMasterName'];
    clusterMasterId = json['ClusterMasterId'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['ClusterMasterName'] = clusterMasterName;
    data['ClusterMasterId'] = clusterMasterId;
    data['IsActive'] = isActive;
    return data;
  }
}
