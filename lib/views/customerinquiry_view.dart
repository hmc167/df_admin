import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customerinquiry_controller.dart';
import '../utils/colors.dart';
import '../widgets/appbar.dart';

class CustomerInquiryView extends StatefulWidget {
  const CustomerInquiryView({super.key});

  @override
  State<CustomerInquiryView> createState() => _CustomerInquiryViewState();
}

class _CustomerInquiryViewState extends State<CustomerInquiryView> {
  final CustomerInquiryController controller = Get.put(
    CustomerInquiryController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text('CustomerInquiry Screen')),
    );
  }
}
