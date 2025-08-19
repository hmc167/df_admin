import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/appbar.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getAppDrawer(),
      appBar: getAppBar(),
      body: Center(child: Text('Products Screen')),
    );
  }
}
