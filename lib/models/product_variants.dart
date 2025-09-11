import 'common.dart';

class ProductVariants {
  ClusterVariantData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ProductVariants(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? ClusterVariantData.fromJson(json['Data']) : null;
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

class ClusterVariantData {
  List<ClusterVariants>? records;
  int? totalRecords;

  ClusterVariantData({this.records, this.totalRecords});

  ClusterVariantData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <ClusterVariants>[];
      json['Records'].forEach((v) {
        records!.add(ClusterVariants.fromJson(v));
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

class ClusterVariants {
  int? id;
  int? clusterMasterId;
  String? name;
  int? minOrderQty;
  bool? isOutOfStock;
  bool? isActive;
  int? sortOrder;
  List<ProductVariant>? productVariants;

  ClusterVariants(
      {this.id,
      this.clusterMasterId,
      this.name,
      this.minOrderQty,
      this.isOutOfStock,
      this.isActive,
      this.sortOrder,
      this.productVariants});

  ClusterVariants.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    clusterMasterId = json['ClusterMasterId'];
    name = json['Name'];
    minOrderQty = json['MinOrderQty'];
    isOutOfStock = json['IsOutOfStock'];
    isActive = json['IsActive'];
    sortOrder = json['SortOrder'];
    if (json['ProductVariants'] != null) {
      productVariants = <ProductVariant>[];
      json['ProductVariants'].forEach((v) {
        productVariants!.add(ProductVariant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ClusterMasterId'] = clusterMasterId;
    data['Name'] = name;
    data['MinOrderQty'] = minOrderQty;
    data['IsOutOfStock'] = isOutOfStock;
    data['IsActive'] = isActive;
    data['SortOrder'] = sortOrder;
    if (productVariants != null) {
      data['ProductVariants'] =
          productVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ClusterVariants copy() {
    return ClusterVariants(
      id: id,
      name: name,
      isActive: isActive,
      isOutOfStock: isOutOfStock,
      clusterMasterId: clusterMasterId,
      minOrderQty: minOrderQty,
      sortOrder: sortOrder,
      productVariants: productVariants != null
          ? List<ProductVariant>.from(
              productVariants!.map((v) => v.copy()))
          : null,
      // Add other properties as needed
    );
  }
}

class ProductVariant {
  int? id;
  int? unitMasterId;
  String? unitName;
  String? notes;
  double? unitValue;
  double? price;
  int? minOrderQty;
  int? maxOrderQty;
  bool? isActive;
  int? sortOrder;

  ProductVariant(
      {this.id,
      this.unitMasterId,
      this.unitName,
      this.notes,
      this.unitValue,
      this.price,
      this.minOrderQty,
      this.maxOrderQty,
      this.isActive,
      this.sortOrder});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    unitMasterId = json['UnitMasterId'];
    unitName = json['UnitName'];
    notes = json['Notes'];
    unitValue = (json["UnitValue"] as num?)?.toDouble();
    price = (json["Price"] as num?)?.toDouble();
    minOrderQty = json['MinOrderQty'];
    maxOrderQty = json['MaxOrderQty'];
    isActive = json['IsActive'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UnitMasterId'] = unitMasterId;
    data['UnitName'] = unitName;
    data['Notes'] = notes;
    data['UnitValue'] = unitValue;
    data['Price'] = price;
    data['MinOrderQty'] = minOrderQty;
    data['MaxOrderQty'] = maxOrderQty;
    data['IsActive'] = isActive;
    data['SortOrder'] = sortOrder;
    return data;
  }

  ProductVariant copy() {
    return ProductVariant(
      id: id,
      unitMasterId: unitMasterId,
      unitName: unitName,
      notes: notes,
      unitValue: unitValue,
      price: price,
      minOrderQty: minOrderQty,
      maxOrderQty: maxOrderQty,
      isActive: isActive,
      sortOrder: sortOrder,

    );
  }
}