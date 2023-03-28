import 'package:expence_trakcer/data/expense_data.dart';
import 'package:expence_trakcer/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import './models/expense_item.dart';
part 'expense_item.g.dart';

void main() async {
  // init hive
  await Hive.initFlutter();
  // register adapter
  Hive.registerAdapter(ExpenseItemAdapter);
  // open hive box
  await Hive.openBox('expenses_database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}