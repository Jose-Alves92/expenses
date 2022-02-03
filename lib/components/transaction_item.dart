import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final Function(String id) _onRemove;
  
  const TransactionItem({
    Key? key,
    required this.tr,
    required Function(String id) onRemove,
  }) : _onRemove = onRemove, super(key: key);


  @override
  Widget build(BuildContext context) {
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
  }
}
