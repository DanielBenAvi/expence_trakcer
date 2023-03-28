import 'package:expence_trakcer/components/expense_summary.dart';
import 'package:expence_trakcer/components/expense_tile.dart';
import 'package:expence_trakcer/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller for expense name
  bool _validate = false;
  final TextEditingController _expenseNameController = TextEditingController();
  // text controller for expense amount
  final TextEditingController _expenseAmountController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepere the data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    // show a dialog to add new expense
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Expense name',
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  hintText: 'Enter expense name',
                ),
                controller: _expenseNameController,
              ),
            ),
            // expense amount
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Expense amount',
                hintText: 'Enter expense amount',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
              ),
              controller: _expenseAmountController,
            ),
            // expense date
          ],
        ),
        actions: [
          // save button
          IconButton(
            onPressed: saveExpense,
            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
          ),
          // cancel button
          IconButton(
            onPressed: cancelExpense,
            icon: const Icon(Icons.cancel_outlined, color: Colors.red),
          ),
        ],
      ),
    );
  }

  /// save the expense
  void saveExpense() {
    // validate the expense name
    if (_expenseNameController.text.isEmpty) {
      setState(() {
        _validate = true;
      });
      return;
    }
    // validate the expense amount using regex
    if (!RegExp(r'^\d+\.?\d{0,2}').hasMatch(_expenseAmountController.text)) {
      setState(() {
        _validate = true;
      });
      return;
    }

    // create a new expense
    ExpenseItem expense = ExpenseItem(
      name: _expenseNameController.text,
      amount: _expenseAmountController.text,
      dateTime: DateTime.now(),
    );
    // save the expense
    Provider.of<ExpenseData>(context, listen: false).addExpense(expense);
    // close the dialog
    clearFields();
    _validate = false;
    Navigator.of(context).pop();
  }

  /// cancel the dialog
  void cancelExpense() {
    // close the dialog
    clearFields();
    Navigator.of(context).pop();
  }

  /// clear the text fields
  void clearFields() {
    _expenseNameController.clear();
    _expenseAmountController.clear();
    _validate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, index) => Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              // weekly summary
              Summary(startOfWeek: value.getStartOfWeek(DateTime.now())),
              // expenses list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.expenses.length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.expenses[index].name,
                  amount: value.expenses[index].amount,
                  dateTime: value.expenses[index].dateTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
