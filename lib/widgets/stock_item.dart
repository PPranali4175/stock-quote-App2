import 'package:flutter/material.dart';
import 'package:stocksapp/models/stock.dart';


class StockItem extends StatelessWidget {
  final StockModel stock;

  const StockItem({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.symbol),
      subtitle: Text('Price: \$${stock.currentPrice}'),
      trailing: Text(
        stock.changeAmount,
        style: TextStyle(
          color: stock.changeAmount.startsWith('-') ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
