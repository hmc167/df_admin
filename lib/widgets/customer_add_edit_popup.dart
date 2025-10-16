import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../models/customer_model.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class CustomerAddEditPopup extends StatefulWidget {
  final CustomerMaster customerMaster;
  final CustomersController controller;

  const CustomerAddEditPopup({
    super.key,
    required this.customerMaster,
    required this.controller,
  });

  @override
  _CustomerAddEditPopupState createState() => _CustomerAddEditPopupState();
}

class _CustomerAddEditPopupState extends State<CustomerAddEditPopup> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController mobileController;
  late TextEditingController balanceController;
  late TextEditingController allowLimitController;
  late RxBool isActive;
  late RxBool isApproved;

  late RxBool callBeforeDelivery;
  late RxBool ringTheBell;
  late RxInt deliverySlotId;
  late RxInt clusterMasterId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.customerMaster.firstName,
    );
    lastNameController = TextEditingController(
      text: widget.customerMaster.lastName,
    );
    mobileController = TextEditingController(
      text: widget.customerMaster.mobile,
    );
    balanceController = TextEditingController(
      text: (widget.customerMaster.balance ?? 0.0).toStringAsFixed(2),
    );
    allowLimitController = TextEditingController(
      text: (widget.customerMaster.allowLimit ?? 0.0).toStringAsFixed(2),
    );
    isActive = (widget.customerMaster.isActive ?? false).obs;
    isApproved = (widget.customerMaster.isApproved ?? false).obs;
    callBeforeDelivery =
        (widget.customerMaster.callBeforeDelivery ?? false).obs;
    ringTheBell = (widget.customerMaster.ringTheBell ?? false).obs;
    deliverySlotId = (widget.customerMaster.deliverySlotId ?? 1).obs;
    clusterMasterId = (widget.customerMaster.clusterMasterId ?? 1).obs;
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    super.dispose();
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
            (widget.customerMaster.id ?? 0) > 0
                ? 'Edit Customer'
                : 'Add Customer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'First Name'),
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(labelText: 'Last Name'),
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: mobileController,
                        decoration: InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        enabled: false,
                        controller: balanceController,
                        decoration: InputDecoration(labelText: 'Balance'),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: allowLimitController,
                        decoration: InputDecoration(
                          labelText: 'Allow Limit (Negative value)',
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          // Only allow numbers and a single decimal point
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
                Row(
                  children: [
                    Text('Cluster : '),
                    DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: clusterMasterId.value,
                      hint: Text('Cluster'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Text('Select'),
                        ),
                        ...List.generate(widget.controller.clusters.length, (
                          index,
                        ) {
                          var cluster = widget.controller.clusters[index];
                          return DropdownMenuItem(
                            value: cluster.iD,
                            child: Text(cluster.name ?? ''),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setState(() {
                          clusterMasterId.value = value ?? 1;
                        });
                        widget.controller.bindDeliverySlots(value ?? 1);
                      },
                    ),
                    Spacer(),
                    Switch(
                      value: isActive.value,
                      onChanged: (value) {
                        setState(() {
                          isActive.value = value;
                        });
                      },
                    ),
                    Text('Is Active'),
                    SizedBox(width: 20),
                    Switch(
                      value: isApproved.value,
                      onChanged: (value) {
                        setState(() {
                          isApproved.value = value;
                        });
                      },
                    ),
                    Text('Is Approved'),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                const Divider(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Delivery Slot : '),
                    DropdownButton<int>(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      value: deliverySlotId.value,
                      hint: Text('Status'),
                      borderRadius: BorderRadius.zero,
                      underline: const DropdownButtonHideUnderline(
                        child: SizedBox.shrink(),
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: null,
                          enabled: false,
                          child: Text('Select'),
                        ),
                        ...List.generate(
                          widget.controller.deliverySlots.length,
                          (index) {
                            var slot = widget.controller.deliverySlots[index];
                            return DropdownMenuItem(
                              value: slot.iD,
                              child: Text(slot.name ?? ''),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          deliverySlotId.value = value ?? 1;
                        });
                      },
                    ),
                    Spacer(),
                    Switch(
                      value: callBeforeDelivery.value,
                      onChanged: (value) {
                        setState(() {
                          callBeforeDelivery.value = value;
                        });
                      },
                    ),
                    Text('Call Before Delivery'),
                    SizedBox(width: 20),
                    Switch(
                      value: ringTheBell.value,
                      onChanged: (value) {
                        setState(() {
                          ringTheBell.value = value;
                        });
                      },
                    ),
                    Text('Ring The Bell'),
                    SizedBox(width: 20),
                  ],
                ),
              ],
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
                  // Validate inputs
                  String firstName = nameController.text.trim();
                  String lastName = lastNameController.text.trim();
                  String mobile = mobileController.text.trim();
                  if (firstName.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'First Name is required.',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                    );
                    return;
                  }
                  if (lastName.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Last Name is required.',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                    );
                    return;
                  }
                  if (mobile.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Mobile is required.',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                    );
                    return;
                  }
                  if (mobile.length != 10) {
                    Get.snackbar(
                      'Error',
                      'Mobile must be 10 digits.',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                    );
                    return;
                  }
                  final newCustomer = CustomerMaster(
                    id: widget.customerMaster.id,
                    lastName: lastNameController.text,
                    firstName: nameController.text,
                    mobile: mobileController.text,
                    balance: double.tryParse(balanceController.text) ?? 0.0,
                    allowLimit:
                        double.tryParse(allowLimitController.text) ?? 0.0,
                    isActive: isActive.value,
                    isApproved: isApproved.value,
                    callBeforeDelivery: callBeforeDelivery.value,
                    ringTheBell: ringTheBell.value,
                    deliverySlotId: deliverySlotId.value,
                    clusterMasterId: clusterMasterId.value,
                  );
                  bool isSaved = await widget.controller.save(newCustomer);

                  if (isSaved) {
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Customer saved successfully',
                      backgroundColor: Colors.greenAccent,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(10),
                    );
                  }
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
