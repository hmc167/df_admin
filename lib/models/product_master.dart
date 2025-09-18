import 'common.dart';

class ProductMasterListModel {
  ProductMasterData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ProductMasterListModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  ProductMasterListModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? ProductMasterData.fromJson(json['Data'])
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

class ProductMasterData {
  List<ProductMaster>? records;
  int? totalRecords;

  ProductMasterData({this.records, this.totalRecords});

  ProductMasterData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <ProductMaster>[];
      json['Records'].forEach((v) {
        records!.add(ProductMaster.fromJson(v));
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

class ProductMasterModel {
  ProductMaster? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ProductMasterModel({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  ProductMasterModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? ProductMaster.fromJson(json['Data'])
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


class ProductMaster {
  int? iD;
  String? name;
  String? unitName;
  int? categoryMasterId;
  String? categoryName;
  bool? isActive;
  bool? isOutOfStock;
  int? sortOrder;
  String? createdBy;
  String? createdDate;
  String? updatedDate;
  String? shortDescription;
  String? description;
  String? goodInfo;
  String? nutrientInfo;
  String? storageTips;
  int? shelfLife;
  int? unitCategoryMasterId;
  String? outOfStockMessage;
  int? minOrderQty;
  String? taxIds;
  List<ClusterMappings>? productClusterMappings;
  List<ProductImages>? productImages;

  ProductMaster({
    this.iD,
    this.name,
    this.unitName,
    this.categoryMasterId,
    this.categoryName,
    this.isActive,
    this.isOutOfStock,
    this.sortOrder,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
    this.shortDescription,
    this.description,
    this.goodInfo,
    this.nutrientInfo,
    this.storageTips,
    this.shelfLife,
    this.unitCategoryMasterId,
    this.outOfStockMessage,
    this.minOrderQty,
    this.taxIds,
    this.productClusterMappings,
    this.productImages,
  });

  ProductMaster.fromJson(Map<String, dynamic> json) {
    iD = json['Id'];
    name = json['Name'];
    unitCategoryMasterId = json['UnitCategoryMasterId'];
    unitName = json['UnitName'];
    categoryMasterId = json['CategoryMasterId'];
    categoryName = json['CategoryName'];
    isActive = json['IsActive'];
    isOutOfStock = json['IsOutOfStock'];
    sortOrder = json['SortOrder'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    description = json['Description'];
    shortDescription = json['ShortDescription'];
    goodInfo = json['GoodInfo'];
    nutrientInfo = json['NutrientInfo'];
    storageTips = json['StorageTips'];
    shelfLife = json['ShelfLife'];
    isOutOfStock = json['IsOutOfStock'];
    outOfStockMessage = json['OutOfStockMessage'];
    minOrderQty = json['MinOrderQty'];
    taxIds = json['TaxIds'];
    if (json['ProductClusterMappings'] != null) {
      productClusterMappings = <ClusterMappings>[];
      json['ProductClusterMappings'].forEach((v) {
        productClusterMappings!.add(ClusterMappings.fromJson(v));
      });
    }
    if (json['ProductImages'] != null) {
      productImages = <ProductImages>[];
      json['ProductImages'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['UnitName'] = unitName;
    data['UnitCategoryMasterId'] = unitCategoryMasterId;
    data['CategoryMasterId'] = categoryMasterId;
    data['CategoryName'] = categoryName;
    data['IsActive'] = isActive;
    data['IsOutOfStock'] = isOutOfStock;
    data['SortOrder'] = sortOrder;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    data['ShortDescription'] = shortDescription;
    data['Description'] = description;
    data['GoodInfo'] = goodInfo;
    data['NutrientInfo'] = nutrientInfo;
    data['StorageTips'] = storageTips;
    data['ShelfLife'] = shelfLife;
    data['IsOutOfStock'] = isOutOfStock;
    data['OutOfStockMessage'] = outOfStockMessage;
    data['MinOrderQty'] = minOrderQty;
    data['TaxIds'] = taxIds;
    if (productClusterMappings != null) {
      data['ProductClusterMappings'] = productClusterMappings!
          .map((v) => v.toJson())
          .toList();
    }
    if (productImages != null) {
      data['ProductImages'] = productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClusterMappings {
  int? iD;
  String? name;
  int? clusterMasterId;
  bool? isOutOfStock;
  bool? isActive;
  int? minOrderQty;
  int? sortOrder;

  ClusterMappings({
    this.iD,
    this.name,
    this.clusterMasterId,
    this.isOutOfStock,
    this.isActive,
    this.minOrderQty,
    this.sortOrder,
  });

  ClusterMappings.fromJson(Map<String, dynamic> json) {
    iD = json['Id'];
    name = json['Name'];
    clusterMasterId = json['ClusterMasterId'];
    isOutOfStock = json['IsOutOfStock'];
    isActive = json['IsActive'];
    minOrderQty = json['MinOrderQty'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = iD;
    data['Name'] = name;
    data['ClusterMasterId'] = clusterMasterId;
    data['IsOutOfStock'] = isOutOfStock;
    data['IsActive'] = isActive;
    data['MinOrderQty'] = minOrderQty;
    data['SortOrder'] = sortOrder;
    return data;
  }
}

class ProductImages {
  int? imageId;
  String? name;
  String? path;
  String? fileKey;
  bool? isDefault;
  bool? isActive;
  int? sortOrder;

  ProductImages({
    this.imageId,
    this.name,
    this.path,
    this.fileKey,
    this.isDefault,
    this.isActive,
    this.sortOrder,
  });

  ProductImages.fromJson(Map<String, dynamic> json) {
    imageId = json['ImageId'];
    name = json['Name'];
    path = json['Path'];
    fileKey = json['FileKey'];
    isDefault = json['IsDefault'];
    isActive = json['IsActive'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ImageId'] = imageId;
    data['Name'] = name;
    data['Path'] = path;
    data['FileKey'] = fileKey;
    data['IsDefault'] = isDefault;
    data['IsActive'] = isActive;
    data['SortOrder'] = sortOrder;
    return data;
  }
}
