import 'common.dart';

class CustomerAddressModel {
  CustomerAddressData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  CustomerAddressModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  CustomerAddressModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new CustomerAddressData.fromJson(json['Data']) : null;
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(new Message.fromJson(v));
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

class CustomerAddressData {
  List<CustomerAddress>? records;
  int? totalRecords;

  CustomerAddressData({this.records, this.totalRecords});

  CustomerAddressData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <CustomerAddress>[];
      json['Records'].forEach((v) {
        records!.add(new CustomerAddress.fromJson(v));
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

class CustomerAddress {
  int? id;
  String? buildingNameNumber;
  String? address1;
  String? address2;
  String? villageORTown;
  int? villageORTownId;
  String? taluka;
  int? talukaId;
  String? district;
  int? districtId;
  String? state;
  int? stateId;
  String? pinCode;
  double? latitude;
  double? longitude;
  int? type;
  bool? isDefault;

  CustomerAddress(
      {this.id,
      this.buildingNameNumber,
      this.address1,
      this.address2,
      this.villageORTown,
      this.villageORTownId,
      this.taluka,
      this.talukaId,
      this.district,
      this.districtId,
      this.state,
      this.stateId,
      this.pinCode,
      this.latitude,
      this.longitude,
      this.type,
      this.isDefault});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    buildingNameNumber = json['BuildingNameNumber'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    villageORTown = json['VillageORTown'];
    villageORTownId = json['VillageORTownId'];
    taluka = json['Taluka'];
    talukaId = json['TalukaId'];
    district = json['District'];
    districtId = json['DistrictId'];
    state = json['State'];
    stateId = json['StateId'];
    pinCode = json['PinCode'];
    latitude = (json['Latitude'] as num?)?.toDouble();
    longitude = (json['Longitude'] as num?)?.toDouble();
    type = json['Type'];
    isDefault = json['IsDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['BuildingNameNumber'] = buildingNameNumber;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['VillageORTown'] = villageORTown;
    data['VillageORTownId'] = villageORTownId;
    data['Taluka'] = taluka;
    data['TalukaId'] = talukaId;
    data['District'] = district;
    data['DistrictId'] = districtId;
    data['State'] = state;
    data['StateId'] = stateId;
    data['PinCode'] = pinCode;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Type'] = type;
    data['IsDefault'] = isDefault;
    return data;
  }
}