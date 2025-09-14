import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../models/customer_address.dart';
import '../models/customer_model.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class CustomerAddressPopup extends StatefulWidget {
  final CustomerMaster customerMaster;
  final CustomersController controller;

  const CustomerAddressPopup({
    super.key,
    required this.customerMaster,
    required this.controller,
  });

  @override
  _CustomerAddressPopupState createState() => _CustomerAddressPopupState();
}

class _CustomerAddressPopupState extends State<CustomerAddressPopup> {
  late TextEditingController buildingNameNumberController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController villageORTownController;
  late TextEditingController talukaController;
  late TextEditingController districtController;
  late TextEditingController stateController;
  late TextEditingController zipCodeController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  CustomerAddress? customerAddress;
  @override
  void initState() {
    super.initState();
    customerAddress = widget.controller.addresses.isNotEmpty
        ? widget.controller.addresses.first
        : null;

    buildingNameNumberController = TextEditingController(
      text: customerAddress?.buildingNameNumber,
    );
    address1Controller = TextEditingController(text: customerAddress?.address1);
    address2Controller = TextEditingController(text: customerAddress?.address2);
    villageORTownController = TextEditingController(
      text: customerAddress?.villageORTown,
    );
    talukaController = TextEditingController(text: customerAddress?.taluka);
    districtController = TextEditingController(text: customerAddress?.district);
    stateController = TextEditingController(text: customerAddress?.state);
    zipCodeController = TextEditingController(text: customerAddress?.pinCode);
    latitudeController = TextEditingController(
      text: customerAddress?.latitude?.toString(),
    );
    longitudeController = TextEditingController(
      text: customerAddress?.longitude?.toString(),
    );
  }

  @override
  void dispose() {
    buildingNameNumberController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    villageORTownController.dispose();
    talukaController.dispose();
    districtController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
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
            'Customer Address (${widget.customerMaster.firstName} ${widget.customerMaster.lastName})',
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
                        controller: buildingNameNumberController,
                        decoration: InputDecoration(
                          labelText: 'Building Name/Number',
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: address1Controller,
                        decoration: InputDecoration(
                          labelText: 'Address Line 1',
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: address2Controller,
                        decoration: InputDecoration(
                          labelText: 'Address Line 2',
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: villageORTownController,
                        decoration: InputDecoration(labelText: 'Village/Town'),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: talukaController,
                        decoration: InputDecoration(labelText: 'Taluka'),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: districtController,
                        decoration: InputDecoration(labelText: 'District'),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: stateController,
                        decoration: InputDecoration(labelText: 'State'),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: zipCodeController,
                        decoration: InputDecoration(labelText: 'PinCode'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: latitudeController,
                        decoration: InputDecoration(labelText: 'Latitude'),
                        inputFormatters: [
                          // Only allow numbers and a single decimal point
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,6}'),
                          ),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: longitudeController,
                        decoration: InputDecoration(labelText: 'Longitude'),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          // Only allow numbers and a single decimal point
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,6}'),
                          ),
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
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
                  final cAddress = CustomerAddress(
                    id: customerAddress?.id ?? 0,
                    buildingNameNumber: buildingNameNumberController.text,
                    address1: address1Controller.text,
                    address2: address2Controller.text,
                    villageORTown: villageORTownController.text,
                    taluka: talukaController.text,
                    district: districtController.text,
                    state: stateController.text,
                    pinCode: zipCodeController.text,
                    latitude: double.tryParse(latitudeController.text) ?? 0.0,
                    longitude: double.tryParse(longitudeController.text) ?? 0.0,
                    type: 1,
                    isDefault: true,
                  );
                  bool isSaved = await widget.controller.saveCustomerAddress(
                    widget.customerMaster.id ?? 0,
                    cAddress,
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
