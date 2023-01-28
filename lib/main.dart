import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontFamily:
                    'OpenSans', 
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              button: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 20 * MediaQuery.textScaleFactorOf(context),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransactions = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransactions);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  Widget _getButtonIcon(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final listIcon = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final chartIcon =
        Platform.isIOS ? CupertinoIcons.chart_bar : Icons.bar_chart;

    final actions = [
      if (_isLandscape)
        _getButtonIcon(_showChart ? listIcon : chartIcon, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getButtonIcon(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context)),
    ];

    final appBar =
        AppBar(title: const Text('Despesas pessoais'), actions: actions);

    final avalibleHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !_isLandscape)
            Container(
                height: avalibleHeight * (_isLandscape ? 0.80 : 0.30),
                child: Chart(_recentTransactions)),
          if (!_showChart || !_isLandscape)
            Container(
                height: avalibleHeight * (_isLandscape ? 1 : 0.70),
                child: TransactionList(_transactions, _removeTransaction)),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage)
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                    elevation: 5,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
