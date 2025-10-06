import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';
import '../models/category_master.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class AddItemPopup extends StatefulWidget {
  final OrdersController controller;

  const AddItemPopup({super.key, required this.controller});

  @override
  _AddItemPopupState createState() => _AddItemPopupState();
}

class _AddItemPopupState extends State<AddItemPopup> {
  int? selectedVariantIndex;
  TextEditingController searchController = TextEditingController(text: '');
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                'Add Item',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Product',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.trim().length > 3) {
                      widget.controller.getProducts(0, value.trim());
                    }
                  },
                ),
              ),

              SizedBox(
                width: 400,
                child: DropdownButtonFormField<CategoryMaster>(
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items: widget.controller.productCategories
                      .map(
                        (category) => DropdownMenuItem<CategoryMaster>(
                          value: category,
                          child: Text(category.name ?? '---'),
                        ),
                      )
                      .toList(),
                  onChanged: (CategoryMaster? newValue) {
                    if (newValue != null) {
                      searchController.text = '';
                      widget.controller.getProducts(newValue.iD ?? 0, '');
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),
        Expanded(
          child: Obx(() {
            return Column(
              children: [
                if (widget.controller.products.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'No products available.',
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.warningColor,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: widget.controller.products.length,
                      itemBuilder: (context, index) {
                        final product = widget.controller.products[index];
                        final variants = product.productVariants ?? [];
                        return ListTile(
                          textColor: ((product.isOutOfStock ?? false) == true)
                              ? Colors.red
                              : Colors.black,
                          title: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(product.name ?? ''),
                              Text(product.categoryName ?? ''),
                            ],
                          ),
                          subtitle: ((product.isOutOfStock ?? false) == true)
                              ? Text('Out of stock')
                              : Text(product.shortDescription ?? ''),
                          trailing: ((product.isOutOfStock ?? false) == true)
                              ? Icon(
                                  Icons.remove_shopping_cart,
                                  size: 40,
                                  color: Colors.grey,
                                )
                              : InkWell(
                                  onTap: () {
                                    TextEditingController qtyController =
                                        TextEditingController();
                                    qtyController.text = '1';
                                    int? dialogSelectedVariantIndex = 0;
                                    widget.controller.selectedVariant.value = 0;

                                    Get.defaultDialog(
                                      backgroundColor: AppColors.textColorWhite,
                                      titleStyle: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      titlePadding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      radius: 8,
                                      title:
                                          'Select Variant & Quantity For ${product.name ?? ''}',
                                      content: StatefulBuilder(
                                        builder: (context, setStateDialog) {
                                          return Column(
                                            children: [
                                              Text(
                                                'Select product variant to add to the order',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.textColor,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              if (variants.isEmpty)
                                                Text(
                                                  'No variants available.',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.warningColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              Column(
                                                children: List<Widget>.generate(
                                                  variants.length,
                                                  (variantIndex) {
                                                    final variant =
                                                        variants[variantIndex];
                                                    return Row(
                                                      children: [
                                                        Switch(
                                                          value:
                                                              variantIndex ==
                                                              widget
                                                                  .controller
                                                                  .selectedVariant
                                                                  .value,
                                                          onChanged: (value) {
                                                            widget
                                                                    .controller
                                                                    .selectedVariant
                                                                    .value =
                                                                variantIndex;
                                                            dialogSelectedVariantIndex =
                                                                variantIndex;
                                                            setStateDialog(
                                                              () {},
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            variant.name ?? '',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          variant.price
                                                                  ?.toStringAsFixed(
                                                                    2,
                                                                  ) ??
                                                              '0.00',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              TextField(
                                                controller: qtyController,
                                                decoration: InputDecoration(
                                                  labelText: "Quantity",
                                                  hintText:
                                                      "Enter the quantity here...",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          );
                                        },
                                      ),
                                      confirm: CommonButton(
                                        width: 100,
                                        text: "Add",
                                        onTap: () {
                                          int quantity =
                                              int.tryParse(
                                                qtyController.text.trim(),
                                              ) ??
                                              1;
                                          if (quantity <= 0) quantity = 1;
                                          var variant =
                                              variants.isNotEmpty &&
                                                  dialogSelectedVariantIndex !=
                                                      null
                                              ? variants[dialogSelectedVariantIndex!]
                                              : null;
                                          if (variant?.id == null) {
                                            return;
                                          } else {
                                            widget.controller.addItemToOrder(
                                              product,
                                              variant,
                                              quantity,
                                            );
                                            Get.back();
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
                                    );
                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart_outlined,
                                    size: 40,
                                  ),
                                ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                        );
                      },
                    ),
                  ),
              ],
            );
          }),
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
            ],
          ),
        ),
      ],
    );
  }
}
