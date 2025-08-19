import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/appbar.dart';

class DailyOrdersView extends StatefulWidget {
  @override
  State<DailyOrdersView> createState() => _DailyOrdersViewState();
}

class _DailyOrdersViewState extends State<DailyOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      body: Center(child: Text('DailyOrders Screen')),
    );
  }
}
