import 'dart:io';

import '../data/api_list.dart';
import '../models/category_master.dart';
import '../models/common.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceCategoryMaster {
  static Future<CategoryMasterModel> all() async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getCategoryMaster,
      {},
    );
    var model = CategoryMasterModel.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> save(
    CategoryMaster category,
  ) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveCategoryMaster, {
          'ID': category.iD,
          'Name': category.name,
          'Desc': category.desc,
          'Image': category.image,
          'SortOrder': category.sortOrder,
          'IsActive': category.isActive,
          'Upcoming': category.upcoming,
          'ParentCategoryMasterId': category.parentCategoryMasterId,
          'CategorytypeId': category.categoryTypeId,
        });
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatus(
    CategoryMaster category,
    int action,
  ) async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.changeCategoryStatus,
      {'ID': category.iD, 'Action': action},
    );
    var model = ChangeStatusResponse.fromJson(response!);
    return model;
  }

  static Future<FileUploadResponse> uploadFile(File file
  ) async {
    final response = await webServiceUploadFile(file);
    var model = FileUploadResponse.fromJson(response!);
    return model;
  }
}
