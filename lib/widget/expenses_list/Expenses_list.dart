import 'package:flutter/cupertino.dart';
import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses,required this.onRemovedExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx,index) =>Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin:EdgeInsets.symmetric(horizontal:Theme.of(context).cardTheme.margin!.horizontal),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction){
            onRemovedExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])
      )
    );
  }

}