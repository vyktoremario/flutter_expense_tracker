import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addHandler;
  const NewTransaction(this.addHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitDataHandler() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addHandler(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentShowDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    return SingleChildScrollView(
      child: Padding(
        padding: isLandScape
            ? EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: mediaQuery.viewInsets.bottom + 10)
            : mediaQuery.viewInsets,
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitDataHandler(),
                  // onChanged: (val) => titleInput = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitDataHandler(),
                  // onChanged: (val) => amountInput = val,
                ),
                Container(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Choosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      AdaptiveFlatButton('Choose a Date', _presentShowDatePicker)
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: _submitDataHandler,
                  child: const Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button?.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
