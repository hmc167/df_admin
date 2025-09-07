import '../data/api_list.dart';
import '../models/unitvariant_master.dart';
import '../models/common.dart';
import '../utils/constants.dart';
import 'web_service_client.dart';

class ApiServiceUnitVariantMaster {
  static Future<UnitVariantMaster> all() async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.getUnitMaster,
      {},
    );
    var model = UnitVariantMaster.fromJson(response!);
    return model;
  }

  static Future<UnitVariantCategoryMaster> allCategory() async {
    final response = await webServiceClientAPI(
      HTTP_POST,
      ApiList.saveUnitCategoryMaster,
      {},
    );
    var model = UnitVariantCategoryMaster.fromJson(response!);
    return model;
  }

  static Future<SaveMasterResponse> save(
    UnitVariant unitVariant,
  ) async {
    final response =
        await webServiceClientAPI(HTTP_POST, ApiList.saveCategoryMaster, {
          'ID': unitVariant.iD,
          'Name': unitVariant.name,
          'SortOrder': unitVariant.sortOrder
        });
    var model = SaveMasterResponse.fromJson(response!);
    return model;
  }

  static Future<ChangeStatusResponse> changeStatus(
    UnitVariant category,
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

}