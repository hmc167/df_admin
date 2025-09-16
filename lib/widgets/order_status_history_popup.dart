import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';
import '../utils/colors.dart';
import 'common_button.dart';

class OrderStatusHistoryPopup extends StatefulWidget {
  final OrdersController controller;

  const OrderStatusHistoryPopup({Key? key, required this.controller})
    : super(key: key);

  @override
  _OrderStatusHistoryPopupState createState() =>
      _OrderStatusHistoryPopupState();
}

class _OrderStatusHistoryPopupState extends State<OrderStatusHistoryPopup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Status History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemCount:
                widget
                    .controller
                    .selectedOrder
                    .value
                    ?.orderStatusHistory
                    ?.length ??
                0,
            itemBuilder: (context, index) {
              var statusEntry = widget
                  .controller
                  .selectedOrder
                  .value
                  ?.orderStatusHistory?[index];
              return ListTile(
                title: Text(statusEntry?.notes ?? ''),
                subtitle: Row(
                  children: [
                    Text(
                      widget.controller.getOrderStatusText(
                            statusEntry?.orderStatus,
                          ) ??
                          '',
                    ),
                    Spacer(),
                    Text(statusEntry?.changeDate ?? ''),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 1, color: Colors.grey.shade300);
            },
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
