import 'package:PersonalExpense/widgets/transaction_item.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;

  TransactionList(this.userTransaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    //fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: userTransaction.map((transaction) {
              return TrasactionItem(
                key: ValueKey(transaction.id),
                transaction: transaction,
                deleteTransaction: deleteTransaction,
              );
            }).toList(),
          );
  }
}
