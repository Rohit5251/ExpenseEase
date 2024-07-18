import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expense.dart';
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();

class NewExpense extends StatefulWidget{
  const NewExpense ({super.key ,required this.onAddExpense});

  final Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState(){
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense>{
  final _titleController=TextEditingController();//handel the User input
  final _amountController=TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory=Category.leisure;
  void _presentDatePicker()async{
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate=await showDatePicker(context: context, firstDate: firstDate, lastDate: now);//available after selected
  setState(() {
    _selectedDate=pickedDate;
  });
  }

  void _submitExpenseData(){
    final enteredAmount=double.tryParse(_amountController.text);//tryParse("Hii")=>null, tryParse('12.34')=>12.34
    final amountIsValid=enteredAmount==null || enteredAmount<=0;
    if(_titleController.text.trim().isEmpty || amountIsValid ||_selectedDate==null ){
      //Error msg
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text('Invalid Input'),
        content:const Text("Please make sure a valid title,amount,date and category was entered ") ,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(ctx);
              },
              child: const Text("Close"),
          ),
        ],
      ),//show POPups
      );
      return;
    }
    widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {//used in Statefull widget {TextEditing class will work continues even if the that widget is not shown so this may cause the app crash so we have to dispose  the TextEditingController method }
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keybordSpace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraint){
      final width=constraint.maxWidth;
      
      return  SizedBox(
        height: double.infinity,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16,48,16,keybordSpace+16),
            child: Column(
              children: [
                if(width>=600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\₹',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                if(width>=600)
                  Row(
                    children: [
                      DropdownButton(     //hard to learn might visit some ather day
                        //Note:-Dropdown doesn't used controller for storing
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category)=>DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toString().toUpperCase(),
                              ),
                            ),
                          ).toList(),
                          onChanged: (value){
                            if(value==null) {
                              return;
                            };
                            setState(() {
                              _selectedCategory=value;
                            });

                            print(value);
                          }
                      ),
                      const SizedBox(width: 24,),
                      Expanded(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate==null ? 'No date is selected' : formatter.format(_selectedDate!)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\₹',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate==null ? 'No date is selected' : formatter.format(_selectedDate!)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                const SizedBox(height: 16,),
                if(width>=600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense")),
                      const SizedBox(width: 9,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"))
                    ],
                  )
                else
                Row(
                  children: [
                    DropdownButton(     //hard to learn might visit some ather day
                      //Note:-Dropdown doesn't used controller for storing
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category)=>DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toString().toUpperCase(),
                            ),
                          ),
                        ).toList(),
                        onChanged: (value){
                          if(value==null) {
                            return;
                          };
                          setState(() {
                            _selectedCategory=value;
                          });

                          print(value);
                        }
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save Expense")),
                    const SizedBox(width: 9,),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}