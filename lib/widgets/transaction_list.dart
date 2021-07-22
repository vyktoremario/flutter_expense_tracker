import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteHandler;

  TransactionList(this.userTransactions, this.deleteHandler);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    'No EXPENSE MADE YET!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(userTransaction: userTransactions[index], deleteHandler: deleteHandler);
            },
            itemCount: userTransactions.length,
          );
  }
}

