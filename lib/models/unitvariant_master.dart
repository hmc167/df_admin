import 'common.dart';

class UnitVariantMaster {
  UnitVariantData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  UnitVariantMaster(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  UnitVariantMaster.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? UnitVariantData.fromJson(json['Data']) : null;
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

class UnitVariantData {
  List<UnitVariant>? records;
  int? totalRecords;

  UnitVariantData({this.records, this.totalRecords});

  UnitVariantData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <UnitVariant>[];
      json['Records'].forEach((v) {
        records!.add(UnitVariant.fromJson(v));
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

class UnitVariant {
  int? iD;
  String? name;
  int? sortOrder;
  double? multiplier;
  double? unitValue;
  int? unitCategoryMasterId;
  String? unitCategoryName;
  String? createdBy;
  String? createdDate;
  String? updatedDate;

  UnitVariant(
      {this.iD,
      this.name,
      this.sortOrder,
      this.multiplier,
      this.unitValue,
      this.unitCategoryMasterId,
      this.unitCategoryName,
      this.createdBy,
      this.createdDate,
      this.updatedDate});

  UnitVariant.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    sortOrder = json['SortOrder'];
    multiplier = json['Multiplier'];
    unitValue = json['UnitValue'];
    unitCategoryMasterId = json['UnitCategoryMasterId'];
    unitCategoryName = json['UnitCategoryName'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['SortOrder'] = sortOrder;
    data['Multiplier'] = multiplier;
    data['UnitValue'] = unitValue;
    data['UnitCategoryMasterId'] = unitCategoryMasterId;
    data['UnitCategoryName'] = unitCategoryName;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    return data;
  }
}

class UnitVariantCategoryMaster {
  UnitVariantCategoryData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  UnitVariantCategoryMaster(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  UnitVariantCategoryMaster.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? UnitVariantCategoryData.fromJson(json['Data']) : null;
    message =
        json['Message'] != null ? Message.fromJson(json['Message']) : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add( Message.fromJson(v));
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

class UnitVariantCategoryData {
  List<UnitCategory>? records;
  int? totalRecords;

  UnitVariantCategoryData({this.records, this.totalRecords});

  UnitVariantCategoryData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <UnitCategory>[];
      json['Records'].forEach((v) {
        records!.add(UnitCategory.fromJson(v));
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

class UnitCategory {
  int? iD;
  String? name;
  int? sortOrder;
  String? createdBy;
  String? createdDate;
  String? updatedDate;

  UnitCategory(
      {this.iD,
      this.name,
      this.sortOrder,
      this.createdBy,
      this.createdDate,
      this.updatedDate});

  UnitCategory.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    sortOrder = json['SortOrder'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['SortOrder'] = sortOrder;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    return data;
  }
}
