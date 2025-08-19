class ProductCategory {
  int? iD;
  String? name;
  String? description;
  int? parentCategoryID;
  bool? status;
  int? sortOrder;

  ProductCategory({
    this.iD,
    this.name,
    this.description,
    this.parentCategoryID,
    this.status,
    this.sortOrder,
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    description = json['Description'];
    parentCategoryID = json['ParentCategoryID'];
    status = json['Status'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Description'] = description;
    data['ParentCategoryID'] = parentCategoryID;
    data['Status'] = status;
    data['SortOrder'] = sortOrder;
    return data;
  }
}
