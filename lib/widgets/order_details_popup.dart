import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';
import '../models/customer_model.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class OrderDetailsPopup extends StatefulWidget {
  final OrdersController controller;

  const OrderDetailsPopup({super.key, required this.controller});

  @override
  _OrderDetailsPopupState createState() => _OrderDetailsPopupState();
}

class _OrderDetailsPopupState extends State<OrderDetailsPopup> {
  final TextEditingController qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final order = widget.controller.selectedOrder.value;
      bool newOrder = order?.id == null || order?.id == 0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Details (${order?.invoiceNumber ?? 'New'})',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.account_box, color: Colors.black, size: 30),
                SizedBox(width: 20),
                if (newOrder)
                  if ((order?.customerId ?? 0) > 0)
                    SizedBox(
                      width: 300,
                      child: Text(
                        order?.customerName ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                if ((order?.customerId ?? 0) == 0)
                  SizedBox(
                    width: 300,
                    child: Autocomplete<CustomerInfo>(
                      displayStringForOption: (CustomerInfo option) =>
                          option.name ?? '',
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text.length < 3) {
                              return const Iterable<CustomerInfo>.empty();
                            }
                            final results = await widget.controller
                                .fetchCustomers(textEditingValue.text);
                            return results;
                          },
                      onSelected: (CustomerInfo? selection) {
                        widget.controller.createOrder(selection?.id ?? 0);
                        // No setState needed, Obx will rebuild
                      },
                      fieldViewBuilder:
                          (
                            context,
                            textController,
                            focusNode,
                            onEditingComplete,
                          ) {
                            return TextField(
                              controller: textController,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText: 'Search customer',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                              ),
                              onEditingComplete: onEditingComplete,
                            );
                          },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: SizedBox(
                              width: 300,
                              height: 600,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  final CustomerInfo option = options.elementAt(
                                    index,
                                  );
                                  return ListTile(
                                    title: Text(
                                      option.name ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    onTap: () => onSelected(option),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (!newOrder)
                  SizedBox(
                    width: 300,
                    child: Text(
                      order?.customerName ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    '🗓️ Date: ${order?.createdDate ?? 'Today'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () async {
                      await widget.controller.orderStatusHistory();
                    },
                    child: Text(
                      'Status: ${widget.controller.getOrderStatusText(order?.orderStatus)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 150,
                  child: Text(
                    '🥦 Qty: ${order?.qty ?? 0}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    '💸 Amount: ${order?.totalAmount?.toStringAsFixed(2) ?? '0.00'}${order?.paymentStatus == 2 ?' (Paid :${order?.paidAmount?.toStringAsFixed(2) ?? ''})':''}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: order?.paymentStatus == 1 ? AppColors.successColor : order?.paymentStatus == 2 ? AppColors.warningColor : AppColors.errorColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(order?.orderDetails?.length ?? 0, (index) {
                      final item = order?.orderDetails![index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      '${item?.name ?? 'Name'} ${item?.varientName ?? ''}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          'Price: ${item?.price?.toStringAsFixed(2) ?? '0.00'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      if (order?.isLock == true)
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Qty: ${item?.qty ?? 0}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      if (order?.isLock == false)
                                        InkWell(
                                          onTap: () {
                                            qtyController.text =
                                                (item?.qty ?? 0).toString();
                                            Get.defaultDialog(
                                              backgroundColor:
                                                  AppColors.textColorWhite,
                                              titleStyle: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10,
                                                  ),
                                              titlePadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10,
                                                  ),
                                              radius: 8,
                                              title: 'Change Qty for ${item?.name ?? ''}',
                                              content: Column(
                                                children: [
                                                  Text(
                                                    'Are you sure you want to change the quantity of this item?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.textColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                    width: 200,
                                                    child: TextField(
                                                      controller: qtyController,
                                                      maxLines: 1,
                                                      decoration: InputDecoration(
                                                        
                                                        labelText: "Quantity",
                                                        hintText:
                                                            "Enter the new quantity",
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        counterText: ''
                                                      ),
                                                      maxLength: 2,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                              confirm: CommonButton(
                                                width: 100,
                                                text: "Update",
                                                onTap: () async {
                                                  var newQty =
                                                      int.tryParse(
                                                        qtyController.text,
                                                      ) ??
                                                      0;
                                                  if (newQty <= 0) {
                                                    Get.snackbar(
                                                      'Error',
                                                      'Quantity must be greater than zero.',
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      colorText: Colors.white,
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      margin: EdgeInsets.all(
                                                        10,
                                                      ),
                                                    );
                                                    return;
                                                  }
                                                  if (newQty ==
                                                      (item?.qty ?? 0)) {
                                                    Get.back();
                                                    return;
                                                  }
                                                  var res = await widget
                                                      .controller
                                                      .modifyItem(
                                                        order?.id ?? 0,
                                                        item?.id ?? 0,
                                                        newQty,
                                                      );
                                                  if (res) {
                                                    Get.back();
                                                  }
                                                },
                                              ),
                                              cancel: CommonButton(
                                                width: 100,
                                                text: "Cancel",
                                                color: AppColors.textColorWhite,
                                                textColor:
                                                    AppColors.primaryColor,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Qty: ${item?.qty ?? 0}',
                                              style: TextStyle(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w500,),
                                            ),
                                          ),
                                        ),
                                      Spacer(),
                                      SizedBox(
                                        child: Text(
                                          'Total: ${item?.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (order?.isLock == false)
                              InkWell(
                                onTap: () {
                                  widget.controller.removeItem(
                                    order?.id ?? 0,
                                    item?.id ?? 0,
                                  );
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withAlpha(20),
                  offset: Offset(0, 0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      if ((order?.orderAddress?.buildingNameNumber ?? '') != '')
                        Text(
                          order?.orderAddress?.buildingNameNumber ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      if ((order?.orderAddress?.address1 ?? '') != '')
                        Text(
                          order?.orderAddress?.address1 ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      if ((order?.orderAddress?.address2 ?? '') != '')
                        Text(
                          order?.orderAddress?.address2 ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      if ((order?.orderAddress?.villageORTown ?? '') != '')
                        Text(
                          order?.orderAddress?.villageORTown ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      if ((order?.orderAddress?.pinCode ?? '') != '')
                        Text(
                          order?.orderAddress?.pinCode ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Item Total :',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.productTotal?.toStringAsFixed(2) ?? '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Discount :',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.discount?.toStringAsFixed(2) ?? '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Delivery Charge :',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.deliveryCharges?.toStringAsFixed(2) ??
                                  '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Platform Charge :',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.platformCharges?.toStringAsFixed(2) ??
                                  '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Handling Charge :',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.handlingCharges?.toStringAsFixed(2) ??
                                  '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Final Total :',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              order?.totalAmount?.toStringAsFixed(2) ?? '0.00',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          if ((order?.notes ?? '') != '') Divider(),
          if ((order?.notes ?? '') != '')
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withAlpha(20),
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                'Notes: ${order?.notes ?? ''}',
                style: TextStyle(fontSize: 18, color: AppColors.textColor),
                textAlign: TextAlign.left,
              ),
            ),
          SizedBox(height: 10),
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
                const SizedBox(width: 20),
                if ((order?.customerId ?? 0) > 0 && order?.isLock == false)
                  CommonButton(
                    text: "Add Item",
                    icon: Icons.add,
                    onTap: () async {
                      await widget.controller.showAddItemDialog(context);
                    },
                  ),
                Spacer(),
                CommonButton(
                  text: "Close",
                  color: AppColors.textColorWhite,
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 20),
                // CommonButton(
                //   text: "Save",
                //   onTap: () async {
                //     // Save logic here
                //     Get.back();
                //     Get.snackbar(
                //       'Success',
                //       'Order saved successfully.',
                //       backgroundColor: Colors.greenAccent,
                //       colorText: Colors.white,
                //       snackPosition: SnackPosition.BOTTOM,
                //       margin: EdgeInsets.all(10),
                //     );
                //   },
                // ),
                // const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      );
    });
  }
}
