import 'dart:ffi';
import 'dart:io';

import '../data/api_list.dart';
import '../models/common.dart';
import '../models/product_master.dart';
import '../models/product_suggests.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceProductMaster {
  static Future<ProductMasterListModel> all(String searchString, {int categoryId = 0, bool? active, bool? isOutOfStock, int pNo = 1, int pSize = 50}) async {
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
      {"ID": pid},
    );
    var model = ProductMasterModel.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> save(ProductMaster product) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveProductMaster, {
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
          "ClusterMappings": product.productClusterMappings,
          "ProductImages": product.productImages,
        });
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

  static Future<ProductSuggests> allSuggests({int status = 0 }) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getProductSuggests,
      {
        "Status": status,
      },
    );
    var model = ProductSuggests.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatusSuggests(
    Long iD,
    int action,
    int status
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeProductStatus,
      {'ID': iD, 'Action': action, 'Status': status},
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<FileUploadResponse> uploadFile(File file) async {
    final response = await webServiceUploadFile(file);
    var model = FileUploadResponse.fromJson(response!);
    return model;
  }
}
