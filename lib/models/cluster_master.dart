import 'common.dart';

class ClusterMasterModel {
  ClusterMasterData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ClusterMasterModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  ClusterMasterModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? ClusterMasterData.fromJson(json['Data'])
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

class ClusterMasterData {
  List<ClusterMaster>? records;
  int? totalRecords;

  ClusterMasterData({this.records, this.totalRecords});

  ClusterMasterData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <ClusterMaster>[];
      json['Records'].forEach((v) {
        records!.add(ClusterMaster.fromJson(v));
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

class ClusterMaster {
  int? iD;
  String? name;
  String? address;
  bool? isActive;
  String? createdBy;
  String? createdDate;
  String? updatedDate;

  ClusterMaster({
    this.iD,
    this.name,
    this.address,
    this.isActive,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
  });

  ClusterMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    address = json['Address'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Address'] = address;
    data['IsActive'] = isActive;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    return data;
  }
}
