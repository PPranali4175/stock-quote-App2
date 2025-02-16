import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stocksapp/models/stock.dart';


class StockProvider with ChangeNotifier {
  StockModel? stockDetails;
  bool isLoading = false;

  Future<void> fetchStockDetails(String symbol) async {
    isLoading = true;
    notifyListeners();

    final apiKey = 'Q60HZLX91TR8RCEA'; 
    final url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('Global Quote')) {
          stockDetails = StockModel.fromJson(data['Global Quote']);
        } else {
          stockDetails = null;
        }
      } else {
        stockDetails = null;
      }
    } catch (error) {
      stockDetails = null;
      print('Error: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}
