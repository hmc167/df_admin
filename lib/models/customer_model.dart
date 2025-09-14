import 'common.dart';

class CustomerMasterModel {
  CustomerMasterData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  CustomerMasterModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  CustomerMasterModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? CustomerMasterData.fromJson(json['Data']) : null;
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

class CustomerMasterData {
  List<CustomerMaster>? records;
  int? totalRecords;

  CustomerMasterData({this.records, this.totalRecords});

  CustomerMasterData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <CustomerMaster>[];
      json['Records'].forEach((v) {
        records!.add(CustomerMaster.fromJson(v));
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

class CustomerMaster {
  int? id;
  int? clusterMasterId;
  String? clusterMasterName;
  String? firstName;
  String? lastName;
  String? mobile;
  String? profileImage;
  bool? isApproved;
  bool? isActive;
  bool? isSelfRegister;
  double? balance;
  double? allowLimit;
  int? deliverySlotId;
  bool? callBeforeDelivery;
  bool? ringTheBell;
  String? createdDate;

  CustomerMaster(
      {this.id,
      this.clusterMasterId,
      this.clusterMasterName,
      this.firstName,
      this.lastName,
      this.mobile,
      this.profileImage,
      this.isApproved,
      this.isActive,
      this.isSelfRegister,
      this.balance,
      this.allowLimit,
      this.deliverySlotId,
      this.callBeforeDelivery,
      this.ringTheBell,
      this.createdDate});

  CustomerMaster.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    clusterMasterId = json['ClusterMasterId'];
    clusterMasterName = json['ClusterMasterName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobile = json['Mobile'];
    profileImage = json['ProfileImage'];
    isApproved = json['IsApproved'];
    isActive = json['IsActive'];
    isSelfRegister = json['IsSelfRegister'];
    balance = (json["Balance"] as num?)?.toDouble();;
    allowLimit = (json['AllowLimit'] as num?)?.toDouble();
    deliverySlotId = json['DeliverySlotID'];
    callBeforeDelivery = json['CallBeforeDelivery'];
    ringTheBell = json['RingTheBell'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ClusterMasterId'] = clusterMasterId;
    data['ClusterMasterName'] = clusterMasterName;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Mobile'] = mobile;
    data['ProfileImage'] = profileImage;
    data['IsApproved'] = isApproved;
    data['IsActive'] = isActive;
    data['IsSelfRegister'] = isSelfRegister;
    data['Balance'] = balance;
    data['AllowLimit'] = allowLimit;
    data['DeliverySlotID'] = deliverySlotId;
    data['CallBeforeDelivery'] = callBeforeDelivery;
    data['RingTheBell'] = ringTheBell;
    data['CreatedDate'] = createdDate;
    return data;
  }
}
