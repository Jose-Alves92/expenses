import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          tr.value.toStringAsFixed(2),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'OpenSans'),
                        ),
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => _onRemove(tr.id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Excluir'),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => _onRemove(tr.id),
                        ),
                ),
              );
            },
          );
  }
}
