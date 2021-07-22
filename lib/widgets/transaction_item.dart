import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteHandler,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${userTransaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.date),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () =>
                    deleteHandler(userTransaction.id),
                icon: const Icon(
                  Icons.delete,
                ),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    deleteHandler(userTransaction.id),
              ),
      ),
    );
  }
}
