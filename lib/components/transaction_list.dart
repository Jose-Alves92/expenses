import '../models/transaction.dart';
import 'transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function(String id) _onRemove;

  TransactionList(this._transactions, this._onRemove);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma Transação cadastrada!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.60,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final tr = _transactions[index];
              return TransactionItem(tr: tr, onRemove: _onRemove);
            },
          );
  }
}

