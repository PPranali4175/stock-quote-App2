import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stocksapp/models/stock.dart';

class StockProvider with ChangeNotifier {
  StockModel? stockDetails;
  bool isLoading = false;

  Future<void> fetchStockDetails(String symbol, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final apiKey = 'Q60HZLX91TR8RCEA';
    final url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('Global Quote') && data['Global Quote'].isNotEmpty) {
          stockDetails = StockModel.fromJson(data['Global Quote']);
          print(data);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data found')),
          );
          stockDetails = null;
        }
      } else {
        stockDetails = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch stock data')),
        );
      }
    } catch (error) {
      stockDetails = null;
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }

    isLoading = false;
    notifyListeners();
  }
}