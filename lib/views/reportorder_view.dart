import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/appbar.dart';

class ReportOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      body: Center(child: Text('ReportOrder Screen')),
    );
  }
}
