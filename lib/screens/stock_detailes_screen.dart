import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stock_provider.dart';

class StockDetailsScreen extends StatefulWidget {
  final String symbol;

  const StockDetailsScreen({Key? key, required this.symbol}) : super(key: key);

  @override
  _StockDetailsScreenState createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  @override
  void initState() {
    super.initState();

   
    Future.microtask(() {
      Provider.of<StockProvider>(context, listen: false)
          .fetchStockDetails(widget.symbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Details: ${widget.symbol}'),
      ),
      body: stockProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : stockProvider.stockDetails == null
              ? const Center(child: Text('No data available'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Symbol: ${stockProvider.stockDetails?.symbol ?? 'N/A'}'),
                      Text('Current Price: \$${stockProvider.stockDetails?.currentPrice ?? 'N/A'}'),
                      Text('Change: ${stockProvider.stockDetails?.changeAmount ?? 'N/A'}'),
                      Text('Change Percent: ${stockProvider.stockDetails?.changePercent ?? 'N/A'}'),
                      Text('Market Cap: ${stockProvider.stockDetails?.marketCap ?? 'N/A'}'),
                    ],
                  ),
                ),
    );
  }
}
