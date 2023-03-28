import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;

  const ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(dateTimeToString),
      trailing: Text('$amount nis'),
    );
  }

  String get dateTimeToString {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
