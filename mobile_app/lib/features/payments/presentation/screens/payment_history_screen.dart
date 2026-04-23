import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Method')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('2026-04-20')),
                  DataCell(Text('Cloud Hosting')),
                  DataCell(Text('USD 29.00')),
                  DataCell(Text('Visa')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('2026-04-19')),
                  DataCell(Text('Internet')),
                  DataCell(Text('USD 55.00')),
                  DataCell(Text('Bank Transfer')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
