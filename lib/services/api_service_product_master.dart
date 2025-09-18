import 'dart:io';

import '../data/api_list.dart';
import '../models/common.dart';
import '../models/product_master.dart';
import '../models/product_search.dart';
import '../models/product_suggests.dart';
import '../models/product_variants.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceProductMaster {
  static Future<ProductMasterListModel> all(
    String searchString, {
    int categoryId = 0,
    bool? active,
    bool? isOutOfStock,
    int pNo = 1,
    int pSize = 50,
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getListProductMaster,
      {
        "PageNo": pNo,
        "PageSize": pSize,
        "SortBy": 0,
        "SortOrder": 0,
        "Filter": {
          "IsOutOfStock": null,
          "Active": null,
          "Name": searchString,
          "CategoryMasterId": categoryId,
        },
      },
    );
    var model = ProductMasterListModel.fromJson(response!);
    return model;
  }

  static Future<ProductMasterModel> get(int pid) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getProductMaster,
      {"Id": pid},
    );
    var model = ProductMasterModel.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> save(ProductMaster product) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.saveProductMaster,
      {
        'Id': product.iD,
        'Name': product.name,
        "ShortDescription": product.shortDescription,
        "Description": product.description,
        "GoodInfo": product.goodInfo,
        "NutrientInfo": product.nutrientInfo,
        "StorageTips": product.storageTips,
        "ShelfLife": product.shelfLife,
        "UnitCategoryMasterId": product.unitCategoryMasterId,
        "CategoryMasterId": product.categoryMasterId,
        "IsOutOfStock": product.isOutOfStock,
        "OutOfStockMessage": product.outOfStockMessage,
        "MinOrderQty": product.minOrderQty,
        "SortOrder": product.sortOrder,
        "IsActive": product.isActive,
        "TaxIds": product.taxIds??'',
        "ClusterMappings": product.productClusterMappings
            ?.map((c) => c.toJson())
            .toList(),
        "ProductImages": product.productImages?.map((c) => c.toJson()).toList(),
      },
    );
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatus(
    ProductMaster product,
    int action,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeProductStatus,
      {'ID': product.iD, 'Action': action},
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<ProductSuggests> allSuggests({int status = 0}) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getProductSuggests,
      {"Status": status},
    );
    var model = ProductSuggests.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatusSuggests(
    int iD,
    int action,
    int status,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeProductSuggestsStatus,
      {'ID': iD, 'Action': action, 'Status': status},
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<ProductVariants> getVarients(int pid) async {
    final response = await webServiceClientAPI(HTTP_POST, ApiList.getVariants, {
      "Id": pid,
    });
    var model = ProductVariants.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> saveVariants(
    int productId,
    ClusterVariants variants,
  ) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveProductVariant, {
          'ID': productId,
          'IsOutOfStock': variants.isOutOfStock,
          'MinOrderQty': variants.minOrderQty,
          'SortOrder': variants.sortOrder,
          'ClusterMappingId': variants.id,
          'ClusterMasterId': variants.clusterMasterId,
          'ProductVariants': variants.productVariants
              ?.where((x) => ((x.id ?? 0) > 0 || (x.isActive ?? false)))
              .map((c) => c.toJson())
              .toList(),
        });
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<FileUploadResponse> uploadFile(File file) async {
    final response = await webServiceUploadFile(file);
    var model = FileUploadResponse.fromJson(response!);
    return model;
  }

  static Future<ProductSearchModel> allSearch(
    int categoryId, {
    String searchString = '',
    int clusterId = 0
  }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getProductSearch,
      {
        "Filter": {
          "ClusterId": clusterId,
          "CategoryId": categoryId,
          "SearchString": searchString
        },
      },
    );
    var model = ProductSearchModel.fromJson(response!);
    return model;
  }

}
