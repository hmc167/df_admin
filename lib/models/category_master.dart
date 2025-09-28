import 'common.dart';

class CategoryMasterModel {
  CategoryMasterData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  CategoryMasterModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  CategoryMasterModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? CategoryMasterData.fromJson(json['Data'])
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

class CategoryMasterData {
  List<CategoryMaster>? records;
  int? totalRecords;

  CategoryMasterData({this.records, this.totalRecords});

  CategoryMasterData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <CategoryMaster>[];
      json['Records'].forEach((v) {
        records!.add(CategoryMaster.fromJson(v));
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

class CategoryMaster {
  int? iD;
  String? name;
  String? desc;
  String? image;
  int? parentCategoryMasterId;
  bool? isActive;
  bool? upcoming;
  int? sortOrder;
  String? createdBy;
  String? createdDate;
  String? parentCategoryMasterName;
  String? updatedDate;
  int? categoryTypeId;
  String? categoryType;

  CategoryMaster({
    this.iD,
    this.name,
    this.desc,
    this.image,
    this.parentCategoryMasterId,
    this.isActive,
    this.upcoming,
    this.sortOrder,
    this.createdBy,
    this.createdDate,
    this.parentCategoryMasterName,
    this.updatedDate,
    this.categoryTypeId,
    this.categoryType,
  });

  CategoryMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    desc = json['Desc'];
    image = json['Image'];
    parentCategoryMasterId = json['ParentCategoryMasterId'];
    isActive = json['IsActive'];
    upcoming = json['Upcoming'];
    sortOrder = json['SortOrder'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    parentCategoryMasterName = json['ParentCategoryMasterName'];
    updatedDate = json['UpdatedDate'];
    categoryTypeId = json['CategoryTypeId'];
    categoryType = json['CategoryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Desc'] = desc;
    data['Image'] = image;
    data['ParentCategoryMasterId'] = parentCategoryMasterId;
    data['IsActive'] = isActive;
    data['Upcoming'] = upcoming;
    data['SortOrder'] = sortOrder;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['ParentCategoryMasterName'] = parentCategoryMasterName;
    data['UpdatedDate'] = updatedDate;
    data['CategoryTypeId'] = categoryTypeId;
    data['CategoryType'] = categoryType;
    return data;
  }
}
