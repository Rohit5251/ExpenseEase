import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widget/chart/chart.dart';
import 'package:expence_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/widget/expenses_list//Expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses=[

  ];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
        context: context,
        builder: (ctx)=>NewExpense(onAddExpense: _addExpense),
    );
  }
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });

  }

    void _removeExpense(Expense expense){
      final expenseIndex=_registeredExpenses.indexOf(expense);
      setState(() {
        _registeredExpenses.remove(expense);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration:const  Duration(seconds: 3),
          content: const Text('Expense deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            },
          ),
          elevation: null, // Explicitly setting elevation to null
        ),
      );

    }


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    Widget mainContent = Container(
      margin:const  EdgeInsets.symmetric(horizontal: 70),
      child:  const Text(""
            "No expenses found. Start adding some",),
    );


    Widget chartContent=const SizedBox(
      width: 0,
    );

    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(expenses: _registeredExpenses,onRemovedExpense: _removeExpense,);
      chartContent=Chart(expenses: _registeredExpenses);
    }
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add))
        ],
      ),
      body:width<600 ? Column(
        children: [
          Expanded(child: chartContent),
          Expanded(child:
              mainContent,
          )
        ],
      ):Row(
        children: [
          Expanded(child: chartContent),
          Expanded(child:
          mainContent,
          )
        ],
    )
    );
  }
}
