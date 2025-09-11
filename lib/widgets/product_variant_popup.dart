import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_master.dart';
import '../models/product_variants.dart';
import '../services/api_service_product_master.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class ProductVariantPopup extends StatefulWidget {
  final ProductMaster product;
  final List<ClusterVariants> clusterVariants;

  const ProductVariantPopup({
    super.key,
    required this.product,
    required this.clusterVariants,
  });

  @override
  State<ProductVariantPopup> createState() => _ProductVariantPopupState();
}

class _ProductVariantPopupState extends State<ProductVariantPopup> {
  late List<ClusterVariants> _clusterVariants;

  @override
  void initState() {
    super.initState();
    // Create a copy to allow local state changes
    _clusterVariants = widget.clusterVariants.map((e) => e.copy()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.product.name ?? '',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _clusterVariants.length,
              itemBuilder: (context, index) {
                final variant = _clusterVariants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  clipBehavior: Clip.none,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and SortOrder
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withAlpha(80),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Expanded(child: Text(variant.name ?? '')),
                              Switch(
                                value: variant.isOutOfStock ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    variant.isOutOfStock = val;
                                  });
                                },
                              ),
                              const Text('Out of Stock'),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                        const Divider(),
                        // Variants grid/list
                        if (variant.productVariants != null &&
                            variant.productVariants!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Variants:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: variant.productVariants!.length,
                                itemBuilder: (context, vIndex) {
                                  final v = variant.productVariants![vIndex];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Switch(
                                            value: v.isActive ?? false,
                                            onChanged: (val) {
                                              setState(() {
                                                v.isActive = val;
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(v.unitName ?? ''),
                                          ),
                                          const SizedBox(width: 16),
                                          SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              initialValue:
                                                  v.price?.toString() ?? '',
                                              decoration: const InputDecoration(
                                                labelText: 'Price',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (val) {
                                                setState(() {
                                                  v.price = double.tryParse(
                                                    val,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          SizedBox(
                                            width: 80,
                                            child: TextFormField(
                                              initialValue:
                                                  v.sortOrder?.toString() ?? '',
                                              decoration: const InputDecoration(
                                                labelText: 'Sort Order',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (val) {
                                                setState(() {
                                                  v.sortOrder = int.tryParse(
                                                    val,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          SizedBox(
                                            width: 90,
                                            child: TextFormField(
                                              initialValue:
                                                  v.minOrderQty?.toString() ??
                                                  '',
                                              decoration: const InputDecoration(
                                                labelText: 'Min Order Qty',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (val) {
                                                setState(() {
                                                  v.minOrderQty = int.tryParse(
                                                    val,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          
                                        ],
                                      ),
                                      if(vIndex != variant.productVariants!.length - 1)
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
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
                  // Call save API here with updated _clusterVariants
                  // For example:
                  // await ApiServiceProductMaster.saveProductVariants(widget.product.id, _clusterVariants);
                  for (var cv in _clusterVariants) {
                    var res = await ApiServiceProductMaster.saveVariants(
                      widget.product.iD ?? 0,
                      cv,
                    );
                  }
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Price updated successfully.',
                    backgroundColor: Colors.greenAccent,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(10),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
