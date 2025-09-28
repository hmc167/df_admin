import 'package:admin/services/api_service_unitvariant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/category_master.dart';
import '../models/product_master.dart';
import '../models/unitvariant_master.dart';
import '../services/api_service_category_master.dart';
import '../services/api_service_product_master.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/common_button.dart';
import '../widgets/product_variant_popup.dart';

class ProductsController extends GetxController {
  final pickedImageFile = Rx<File?>(null);
  final imageNameController = TextEditingController();
  final imageSortOrderController = TextEditingController();

  final filterNameController = TextEditingController();
  final filterCategoryId = 0.obs;
  final filterStatus = 0.obs;

  final nameController = TextEditingController();
  final sortOrderController = TextEditingController();
  final categoryMasterId = 0.obs;
  final unitCategoryId = 0.obs;
  final status = false.obs;
  final isOutOfStock = false.obs;
  final outOfStockMessageController = TextEditingController();

  final descriptionController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final goodInfoController = TextEditingController();
  final nutrientInfoController = TextEditingController();
  final storageTipsController = TextEditingController();
  final shelfLifeController = TextEditingController();
  final searchKeyController = TextEditingController();

  final nameFocusNode = FocusNode();
  final parentCategoryFocusNode = FocusNode();
  final sortOrderFocusNode = FocusNode();
  final statusFocusNode = FocusNode();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  RxList<ProductMaster> products = <ProductMaster>[].obs;
  RxList<CategoryMaster> productCategories = <CategoryMaster>[].obs;
  RxList<UnitCategory> productUnits = <UnitCategory>[].obs;
  RxList<ProductImages> imagesList = <ProductImages>[].obs;
  RxList<ClusterMappings> clusterMappings = <ClusterMappings>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getUnitCategories();
    Future.delayed(Duration(milliseconds: 300), () {
      nameFocusNode.requestFocus();
    });
  }

  void loadData() {
    getProducts();
  }

  void toggleStatus() {
    status.value = !status.value;
  }

  void clearFields() {
    pickedImageFile.value = null;
    imageSortOrderController.clear();
    imageNameController.clear();

    nameController.clear();
    sortOrderController.clear();
    categoryMasterId.value = 0;
    unitCategoryId.value = 0;
    status.value = false;
    isOutOfStock.value = false;
    outOfStockMessageController.clear();

    descriptionController.clear();
    shortDescriptionController.clear();
    goodInfoController.clear();
    nutrientInfoController.clear();
    storageTipsController.clear();
    shelfLifeController.clear();
    searchKeyController.clear();

    imagesList.value = [];
    clusterMappings.value = [];

    nameFocusNode.requestFocus();
  }

  Future<void> openAddProductPopup(ProductMaster product) async {
    clearFields();
    int productId = product.iD ?? 0;
    if (productId > 0) {
      final result = await ApiServiceProductMaster.get(productId);
      if (result.hasError == false) {
        var dbProduct = result.data!;
        product = dbProduct;
        if (dbProduct.productImages?.isNotEmpty ?? false) {
          imagesList.value = dbProduct.productImages!;
        }
        if (dbProduct.productClusterMappings?.isNotEmpty ?? false) {
          clusterMappings.value = dbProduct.productClusterMappings!;
        }
      }
    }
    nameController.text = product.name ?? '';
    sortOrderController.text = product.sortOrder?.toString() ?? '';
    categoryMasterId.value = product.categoryMasterId ?? 0;
    unitCategoryId.value = product.unitCategoryMasterId ?? 0;

    status.value = product.isActive ?? false;
    isOutOfStock.value = product.isOutOfStock ?? false;
    outOfStockMessageController.text = product.outOfStockMessage ?? '';

    descriptionController.text = product.description ?? '';
    shortDescriptionController.text = product.shortDescription ?? '';
    goodInfoController.text = product.goodInfo ?? '';
    nutrientInfoController.text = product.nutrientInfo ?? '';
    storageTipsController.text = product.storageTips ?? '';
    shelfLifeController.text = (product.shelfLife ?? 0).toString();
    searchKeyController.text = product.searchKey ?? '';

    await Helpers.showPopup(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              productId > 0 ? 'Edit Product (${product.name})' : 'Add New Product',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.infoColor,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.textColor,
                      unselectedLabelColor: AppColors.textColor,
                      tabs: [
                        Tab(text: 'General Info'),
                        Tab(text: 'Images'),
                        Tab(text: 'Cluster'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // General Info Tab
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: nameFocusNode,
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        labelText: 'Name',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Obx(
                                        () => DropdownButton<int>(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          value: categoryMasterId.value,
                                          isExpanded: true,
                                          borderRadius: BorderRadius.zero,
                                          underline:
                                              const DropdownButtonHideUnderline(
                                                child: SizedBox.shrink(),
                                              ),
                                          items: productCategories
                                              .map(
                                                (category) =>
                                                    DropdownMenuItem<int>(
                                                      value: category.iD ?? 0,
                                                      child: Text(
                                                        category.name ?? '',
                                                      ),
                                                    ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            categoryMasterId.value = value ?? 0;
                                          },
                                          hint: Text('Select Category'),
                                          dropdownColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Obx(
                                        () => DropdownButton<int>(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          value: unitCategoryId.value,
                                          isExpanded: true,
                                          borderRadius: BorderRadius.zero,
                                          underline:
                                              const DropdownButtonHideUnderline(
                                                child: SizedBox.shrink(),
                                              ),
                                          items: productUnits
                                              .map(
                                                (unitCategory) =>
                                                    DropdownMenuItem<int>(
                                                      value:
                                                          unitCategory.iD ?? 0,
                                                      child: Text(
                                                        unitCategory.name ?? '',
                                                      ),
                                                    ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            unitCategoryId.value = value ?? 0;
                                          },
                                          hint: Text('Select Unit'),
                                          dropdownColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: sortOrderController,
                                      decoration: InputDecoration(
                                        hintText: 'Sort Order',
                                        labelText: 'Sort Order',
                                        border: OutlineInputBorder(),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType: TextInputType.number,
                                      focusNode: sortOrderFocusNode,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Active',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => CupertinoSwitch(
                                            value: status.value,
                                            onChanged: (value) {
                                              status.value = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Out Of Stock',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Obx(
                                          () => CupertinoSwitch(
                                            value: isOutOfStock.value,
                                            onChanged: (value) {
                                              isOutOfStock.value = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      //focusNode: nameFocusNode,
                                      controller: outOfStockMessageController,
                                      decoration: InputDecoration(
                                        hintText: 'OutOfStock Message',
                                        labelText: 'OutOfStock Message',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Divider(),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: shortDescriptionController,
                                      decoration: InputDecoration(
                                        hintText: 'Short Description',
                                        labelText: 'Short Description',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: descriptionController,
                                      decoration: InputDecoration(
                                        hintText: 'Description',
                                        labelText: 'Description',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Divider(),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: goodInfoController,
                                      decoration: InputDecoration(
                                        hintText: 'GoodInfo',
                                        labelText: 'GoodInfo',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: nutrientInfoController,
                                      decoration: InputDecoration(
                                        hintText: 'NutrientInfo',
                                        labelText: 'NutrientInfo',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: storageTipsController,
                                      decoration: InputDecoration(
                                        hintText: 'StorageTips',
                                        labelText: 'StorageTips',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: shelfLifeController,
                                      decoration: InputDecoration(
                                        hintText: 'ShelfLife',
                                        labelText: 'ShelfLife',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: searchKeyController,
                                      decoration: InputDecoration(
                                        hintText: 'Search Keys',
                                        labelText: 'Search Keys',
                                        border: OutlineInputBorder(),
                                        alignLabelWithHint: true,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          // Images Tab
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return SizedBox(
                                    height: 102,
                                    child: Row(
                                      children: [
                                        // Image picker button
                                        if (pickedImageFile.value != null)
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            child: pickedImageFile.value != null
                                                ? Image.file(
                                                    pickedImageFile.value!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Icon(
                                                    Icons.image,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                          ),

                                        if (pickedImageFile.value == null)
                                          ElevatedButton.icon(
                                            icon: Icon(Icons.add_a_photo),
                                            label: Text('Upload Image'),
                                            onPressed: () async {
                                              final picker = ImagePicker();
                                              final picked = await picker
                                                  .pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                              if (picked != null) {
                                                pickedImageFile.value = File(
                                                  picked.path,
                                                );
                                              }
                                            },
                                          ),
                                        SizedBox(width: 20),
                                        // Name input for image
                                        SizedBox(
                                          width: 400,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Image Name',
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: imageNameController,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        SizedBox(
                                          width: 120,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Sort Order',
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                3,
                                              ),
                                            ],
                                            controller:
                                                imageSortOrderController,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        // Save image button
                                        ElevatedButton(
                                          child: Text('Add Image'),
                                          onPressed: () async {
                                            if (pickedImageFile.value == null ||
                                                imageNameController
                                                    .text
                                                    .isEmpty ||
                                                imageSortOrderController
                                                    .text
                                                    .isEmpty) {
                                              Get.snackbar(
                                                'Error',
                                                'Please select an image and fill all fields',
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Colors.white,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: EdgeInsets.all(10),
                                              );
                                              return;
                                            }
                                            final result =
                                                await ApiServiceCategoryMaster.uploadFile(
                                                  pickedImageFile.value!,
                                                );
                                            if (result.hasError == false) {
                                              var imageTempKey =
                                                  result.data?.fileKey ?? '';
                                              var imageTempPath =
                                                  result.data?.fileUrl ?? '';
                                              final newImage = ProductImages(
                                                imageId: 0,
                                                path: imageTempPath,
                                                fileKey: imageTempKey,
                                                name: imageNameController.text,
                                                sortOrder:
                                                    int.tryParse(
                                                      imageSortOrderController
                                                          .text,
                                                    ) ??
                                                    0,
                                                isDefault: false,
                                                isActive: true,
                                              );

                                              imagesList.add(newImage);
                                              clearAddImage();
                                            } else {
                                              Get.snackbar(
                                                'Upload Error',
                                                result
                                                        .errors
                                                        ?.firstOrNull
                                                        ?.message ??
                                                    'Error uploading image',
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Colors.white,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: EdgeInsets.all(10),
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        // Save image button
                                        ElevatedButton(
                                          child: Text('Reset'),
                                          onPressed: () {
                                            clearAddImage();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                SizedBox(height: 24),
                                Text(
                                  'Images',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // List of images
                                Expanded(
                                  child: Obx(() {
                                    return ListView.builder(
                                      itemCount: imagesList.length,
                                      itemBuilder: (context, index) {
                                        final image = imagesList[index];
                                        return Card(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 60,
                                              color: Colors.grey[200],
                                              child: Image.network(
                                                image.path ?? '',
                                              ),
                                            ),
                                            title: Text(image.name ?? ''),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  'Sort Order: ${image.sortOrder}',
                                                ),
                                                SizedBox(width: 16),
                                                if (image.isDefault ?? false)
                                                  Text('Default'),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                if (image.imageId == 0) {
                                                  imagesList.value = imagesList
                                                      .value
                                                      .where(
                                                        (x) =>
                                                            x.path !=
                                                            image.path,
                                                      )
                                                      .toList();
                                                } else {
                                                  //DB call for remove image
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          //Cluster Tab
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clusters',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // List of images
                                Expanded(
                                  child: Obx(() {
                                    return ListView.builder(
                                      itemCount: clusterMappings.length,
                                      itemBuilder: (context, index) {
                                        final cluster = clusterMappings[index];
                                        return Card(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          child: ListTile(
                                            title: Text(cluster.name ?? ''),
                                            subtitle: Row(
                                              children: [
                                                if (cluster.isActive ?? false)
                                                  Text('Active'),
                                              ],
                                            ),
                                            trailing:
                                                (cluster.isActive ?? false)
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      cluster.isActive = false;
                                                      clusterMappings[index] =
                                                          cluster;
                                                      clusterMappings.refresh();
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      cluster.isActive = true;
                                                      clusterMappings[index] =
                                                          cluster;
                                                      clusterMappings.refresh();
                                                    },
                                                  ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 0),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  text: "Close",
                  color: AppColors.textColorWhite,
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 20),
                CommonButton(
                  text: "Save",
                  onTap: () async {
                    await saveProduct(productId);
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void clearAddImage() {
    pickedImageFile.value = null;
    imageNameController.clear();
    imageSortOrderController.clear();
  }

  Future<void> saveProduct(int productId) async {
    try {
      if (nameController.text.isEmpty) {
        Get.snackbar(
          'Warning',
          'Name cannot be empty',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }

      if (sortOrderController.text.isEmpty) {
        Get.snackbar(
          'Warning',
          'Sort Order cannot be empty',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
      var unitCategoryMasterId = unitCategoryId.value;
      var categoryId = categoryMasterId.value;

      if (categoryId == 0) {
        Get.snackbar(
          'Warning',
          'Please select category',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }

      if (unitCategoryMasterId == 0) {
        Get.snackbar(
          'Warning',
          'Please select unit category',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }

      //List<ClusterMappings> clusterMappings = [];
      List<ProductImages> saveImagesList = [];
      if (imagesList.value.isNotEmpty) {
        imagesList.forEach((image) {
          image.path = image.fileKey ?? image.path?.trim();
          saveImagesList.add(image);
        });
      }
      final newProduct = ProductMaster(
        iD: productId,
        name: nameController.text,
        description: descriptionController.text,
        shortDescription: shortDescriptionController.text,
        goodInfo: goodInfoController.text,
        nutrientInfo: nutrientInfoController.text,
        storageTips: storageTipsController.text,
        shelfLife: int.parse(shelfLifeController.text),
        searchKey: searchKeyController.text,
        unitCategoryMasterId: unitCategoryMasterId,
        categoryMasterId: categoryId,
        isOutOfStock: isOutOfStock.value,
        outOfStockMessage: outOfStockMessageController.text,
        minOrderQty: 0,
        sortOrder: int.tryParse(sortOrderController.text) ?? 0,
        isActive: status.value,
        productClusterMappings: clusterMappings.value,
        productImages: saveImagesList,
      );

      final result = await ApiServiceProductMaster.save(newProduct);
      if (result.hasError == false) {
        clearFields();
        Get.back();
        Get.snackbar(
          'Success',
          'Product saved successfully',
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        await getProducts();
      } else {
        Get.snackbar(
          'Error',
          result.errors?.firstOrNull?.message ?? 'Error saving Product',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void deleteProduct(ProductMaster product) {
    if (product.iD != null) {
      Get.defaultDialog(
        backgroundColor: AppColors.textColorWhite,
        titleStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        titlePadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        radius: 4,
        confirm: CommonButton(
          width: 100,
          text: "Delete",
          onTap: () async {
            final result = await ApiServiceProductMaster.changeStatus(
              product,
              ChangeStatusAction.delete,
            );
            if (result.data == true) {
              Get.back();
              Get.snackbar(
                'Success',
                'Product deleted successfully',
                backgroundColor: Colors.greenAccent,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(10),
              );
              await getProducts();
            }
          },
        ),
        cancel: CommonButton(
          width: 100,
          text: "Cancel",
          color: AppColors.textColorWhite,
          textColor: AppColors.primaryColor,
          onTap: () {
            Get.back();
          },
        ),
        title: 'Confirm Delete',
        middleText:
            'Are you sure you want to delete this product (${product.name})?\nThis action cannot be reversed.\n',
      );
    } else {
      Get.snackbar(
        'Delete Error',
        'Cannot delete a product without an ID',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }

  Future<void> getProducts() async {
    int status = filterStatus.value;
    final result = await ApiServiceProductMaster.all(
      filterNameController.text,
      active: (status == 0) ? null : (status == 1 ? true : false),
      categoryId : filterCategoryId.value,
    );
    if (result.hasError == false) {
      var dbProducts = result.data?.records ?? [];
      if (dbProducts.isNotEmpty) {
        products.value = dbProducts;
      }
    } else {
      errorMessage.value =
          result.errors?.firstOrNull?.message ?? 'No record found';
    }
  }

  Future<void> getCategories() async {
    final result = await ApiServiceCategoryMaster.all();
    if (result.hasError == false) {
      var dbCategories = result.data?.records ?? [];
      if (dbCategories.isNotEmpty) {
        var pCats = [
          CategoryMaster(
            iD: 0,
            name: 'Select Category',
            parentCategoryMasterId: null,
            isActive: true,
          ),
        ];
        pCats.addAll(
          dbCategories.toList(),
          // .where((c) => (c.parentCategoryMasterId ?? 0) != 0)
          // .toList(),
        );
        productCategories.value = pCats;
      }
    }
  }

  Future<void> getUnitCategories() async {
    final result = await ApiServiceUnitVariantMaster.allCategory();
    var pCats = [UnitCategory(iD: 0, name: 'Select Unit')];
    if (result.hasError == false) {
      var dbUnitCategories = result.data?.records ?? [];
      pCats.addAll(dbUnitCategories);
    }
    productUnits.value = pCats;
  }

  Future<void> resetSearchFilters() async {
    filterNameController.clear();
    filterCategoryId.value = 0;
    filterStatus.value = 0;
    await searchProducts();
  }

  Future<void> searchProducts() async {
    await getProducts();
    // String text = filterNameController.text;
    // int value = filterCategoryId.value;
    // int value2 = filterStatus.value;

    // List<ProductMaster> filtered = products.where((product) {
    //   final matchesName =
    //       text.isEmpty ||
    //       (product.name?.toLowerCase().contains(text.toLowerCase()) ?? false);
    //   final matchesParent = value == 0 || product.categoryMasterId == value;
    //   final matchesStatus =
    //       value2 == 0 ||
    //       (value2 == 1 ? product.isActive == true : product.isActive == false);
    //   return matchesName && matchesParent && matchesStatus;
    // }).toList();
    // products.value = filtered;
  }

  Future<void> openManageProductVariantPopup(ProductMaster product) async {
    int productId = product.iD ?? 0;
    if (productId > 0) {
      var productVariants = await ApiServiceProductMaster.getVarients(
        productId,
      );
      if (productVariants.hasError == false) {
        Helpers.showPopup(
          ProductVariantPopup(
            product: product,
            clusterVariants: productVariants.data?.records ?? [],
          ),
          width: 900,
        );
      } else {
        Get.snackbar(
          'Error',
          productVariants.errors?.firstOrNull?.message ??
              'Error loading variants',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
      }
    }
  }
}
