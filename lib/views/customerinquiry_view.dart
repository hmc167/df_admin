import 'package:admin/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerInquiryView extends StatefulWidget {
  const CustomerInquiryView({super.key});

  @override
  State<CustomerInquiryView> createState() => _CustomerInquiryViewState();
}

class _CustomerInquiryViewState extends State<CustomerInquiryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      body: Center(child: Text('CustomerInquiry Screen')),
    );
  }
}
