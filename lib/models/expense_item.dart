import 'package:hive/hive.dart';
part 'expense_item.g.dart';
// run flutter packages pub run build_runner build

@HiveType(typeId: 1)
class ExpenseItem {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String amount;
  @HiveField(2)
  final DateTime dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  });
}
