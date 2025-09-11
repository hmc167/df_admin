import 'common.dart';

class ProductSuggests {
  ProductSuggestData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ProductSuggests(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  ProductSuggests.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new ProductSuggestData.fromJson(json['Data']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (this.message != null) {
      data['Message'] = this.message!.toJson();
    }
    if (this.errors != null) {
      data['Errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['HasError'] = this.hasError;
    data['HasInfo'] = this.hasInfo;
    return data;
  }
}

class ProductSuggestData {
  List<ProductSuggest>? records;
  int? totalRecords;

  ProductSuggestData({this.records, this.totalRecords});

  ProductSuggestData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <ProductSuggest>[];
      json['Records'].forEach((v) {
        records!.add(new ProductSuggest.fromJson(v));
      });
    }
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['Records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['TotalRecords'] = this.totalRecords;
    return data;
  }
}

class ProductSuggest {
  int? id;
  String? name;
  bool? isActive;
  int? status;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;

  ProductSuggest(
      {this.id,
      this.name,
      this.isActive,
      this.status,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate});

  ProductSuggest.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isActive = json['IsActive'];
    status = json['Status'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedBy = json['UpdatedBy'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    data['Status'] = this.status;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}

