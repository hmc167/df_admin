import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int dailyOrders = 120;
  int pendingOrders = 15;
  int completedOrders = 105;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.blue),
                title: Text('Total Orders'),
                trailing: Text('$dailyOrders'),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.pending_actions, color: Colors.orange),
                title: Text('Pending Orders'),
                trailing: Text('$pendingOrders'),
              ),
            ),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Completed Orders'),
                trailing: Text('$completedOrders'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
