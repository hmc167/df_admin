import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/appbar.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      body: Center(child: Text('Customers Screen')),
    );
  }
}
