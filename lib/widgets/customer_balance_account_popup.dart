import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../models/customer_balance_history.dart';
import '../models/customer_model.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class CustomerBalanceAccountPopup extends StatefulWidget {
  final CustomerMaster customerMaster;
  final CustomersController controller;

  const CustomerBalanceAccountPopup({
    super.key,
    required this.customerMaster,
    required this.controller,
  });

  @override
  _CustomerBalanceAccountPopupState createState() =>
      _CustomerBalanceAccountPopupState();
}

class _CustomerBalanceAccountPopupState
    extends State<CustomerBalanceAccountPopup> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _remarksController.dispose();
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
          child: Row(
            children: [
              Text(
                'Customer (${widget.customerMaster.firstName} ${widget.customerMaster.lastName}) Balance & Balance History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                'Current Balance: ${widget.customerMaster.balance?.toStringAsFixed(2) ?? '0.00'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Allow Limit: ${widget.customerMaster.allowLimit?.toStringAsFixed(2) ?? '0.00'}',
                      ),
                      const Divider(),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: _amountController,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Remarks',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        controller: _remarksController,
                      ),
                      SizedBox(height: 10),
                      CommonButton(
                        text: "Add Balance",
                        color: AppColors.primaryColor,
                        textColor: AppColors.textColorWhite,
                        onTap: () async {
                          final amount = double.tryParse(
                            _amountController.text,
                          );
                          final remarks = _remarksController.text.trim();
                          if (amount != null && remarks.isNotEmpty) {
                            var result = await widget.controller.addBalance(
                              widget.customerMaster,
                              amount,
                              remarks,
                            );
                            if (result) {
                              widget.customerMaster.balance =
                                  (widget.customerMaster.balance ?? 0) + amount;
                              _amountController.clear();
                              _remarksController.clear();
                              setState(() {});
                            }
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please enter valid amount and remarks',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: widget.controller.balanceHistory.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    widget.controller.balanceHistory.length,
                                itemBuilder: (context, index) {
                                  final history =
                                      widget.controller.balanceHistory[index];
                                  return ListTile(
                                    title: Text(history.remarks ?? ''),
                                    subtitle: Text('${history.createdDate}'),
                                    leading: Icon(
                                      history.transactionType == 1
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: history.transactionType == 1
                                          ? AppColors.successColor
                                          : AppColors.errorColor,
                                    ),
                                    trailing: history.transactionType == 1
                                        ? Text(
                                            '+ ${history.transactionBalance?.toStringAsFixed(2) ?? '0.00'}',
                                            style: TextStyle(
                                              color: AppColors.successColor,
                                              fontSize: 16,
                                            ),
                                          )
                                        : Text(
                                            '- ${history.transactionBalance?.toStringAsFixed(2) ?? '0.00'}',
                                            style: TextStyle(
                                              color: AppColors.errorColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                  );
                                },
                              )
                            : Center(child: Text('No balance history found')),
                      ),
                    ],
                  ),
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
            ],
          ),
        ),
      ],
    );
  }
}
