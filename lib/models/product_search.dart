import 'common.dart';

class ProductSearchModel {
  ProductSearchData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ProductSearchModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? ProductSearchData.fromJson(json['Data']) : null;
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

class ProductSearchData {
  List<Product>? records;
  int? totalRecords;

  ProductSearchData({this.records, this.totalRecords});

  ProductSearchData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <Product>[];
      json['Records'].forEach((v) {
        records!.add(Product.fromJson(v));
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

class Product {
  int? id;
  String? name;
  String? shortDescription;
  String? categoryName;
  String? unitName;
  bool? isOutOfStock;
  String? outOfStockMessage;
  int? sortOrder;
  int? categoryMasterId;
  String? imagePath;
  List<ProductSearchVariants>? productVariants;

  Product(
      {this.id,
      this.name,
      this.shortDescription,
      this.categoryName,
      this.unitName,
      this.isOutOfStock,
      this.outOfStockMessage,
      this.sortOrder,
      this.categoryMasterId,
      this.imagePath,
      this.productVariants});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    shortDescription = json['ShortDescription'];
    categoryName = json['CategoryName'];
    unitName = json['UnitName'];
    isOutOfStock = json['IsOutOfStock'];
    outOfStockMessage = json['OutOfStockMessage'];
    sortOrder = json['SortOrder'];
    categoryMasterId = json['CategoryMasterId'];
    imagePath = json['ImagePath'];
    if (json['ProductVariants'] != null) {
      productVariants = <ProductSearchVariants>[];
      json['ProductVariants'].forEach((v) {
        productVariants!.add(ProductSearchVariants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['ShortDescription'] = shortDescription;
    data['CategoryName'] = categoryName;
    data['UnitName'] = unitName;
    data['IsOutOfStock'] = isOutOfStock;
    data['OutOfStockMessage'] = outOfStockMessage;
    data['SortOrder'] = sortOrder;
    data['CategoryMasterId'] = categoryMasterId;
    data['ImagePath'] = imagePath;
    if (productVariants != null) {
      data['ProductVariants'] =
          productVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSearchVariants {
  int? id;
  double? price;
  double? unitValue;
  int? unitMasterId;
  String? name;
  String? notes;
  int? maxOrderQty;
  int? minOrderQty;
  int? sortOrder;

  ProductSearchVariants(
      {this.id,
      this.price,
      this.unitValue,
      this.unitMasterId,
      this.name,
      this.notes,
      this.maxOrderQty,
      this.minOrderQty,
      this.sortOrder});

  ProductSearchVariants.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    price = (json['Price'] as num?)?.toDouble();
    unitValue = (json['UnitValue'] as num?)?.toDouble();
    unitMasterId = json['UnitMasterId'];
    name = json['Name'];
    notes = json['Notes'];
    maxOrderQty = json['MaxOrderQty'];
    minOrderQty = json['MinOrderQty'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Price'] = price;
    data['UnitValue'] = unitValue;
    data['UnitMasterId'] = unitMasterId;
    data['Name'] = name;
    data['Notes'] = notes;
    data['MaxOrderQty'] = maxOrderQty;
    data['MinOrderQty'] = minOrderQty;
    data['SortOrder'] = sortOrder;
    return data;
  }
}