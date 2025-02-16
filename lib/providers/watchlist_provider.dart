import 'package:flutter/foundation.dart';
import 'package:stocksapp/models/stock.dart';


class WatchlistProvider extends ChangeNotifier {
  
  final List<StockModel> _watchlist = [];

  
  List<StockModel> get watchlist => _watchlist;

  
  void addToWatchlist(StockModel stock) {
    
    if (!_watchlist.any((item) => item.symbol == stock.symbol)) {
      _watchlist.add(stock);
      notifyListeners(); 
    }
  }

 
  void removeFromWatchlist(String symbol) {
    _watchlist.removeWhere((item) => item.symbol == symbol);
    notifyListeners(); 
  }

  
  void clearWatchlist() {
    _watchlist.clear();
    notifyListeners();
  }
}
