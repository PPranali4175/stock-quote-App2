import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stock_provider.dart';
import '../providers/watchlist_provider.dart';
import '../widgets/watchlist_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final watchlistProvider = Provider.of<WatchlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock Quote App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 119, 72, 201),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Enter Stock Symbol',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final symbol = _searchController.text.trim();
                      if (symbol.isNotEmpty) {
                        stockProvider.fetchStockDetails(symbol,context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 116, 70, 196),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

          
            stockProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : stockProvider.stockDetails != null
                    ? Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Symbol: ${stockProvider.stockDetails?.symbol}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 113, 67, 192),
                                ),
                              ),
                              Text(
                                'Current Price: \$${stockProvider.stockDetails?.currentPrice}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Change: ${stockProvider.stockDetails?.changeAmount} (${stockProvider.stockDetails?.changePercent}%)',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: stockProvider.stockDetails!.changeAmount.startsWith('-')
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              Text(
                                'Market Cap: ${stockProvider.stockDetails?.marketCap ?? 'N/A'}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  final stock = stockProvider.stockDetails!;
                                  if (watchlistProvider.watchlist.any(
                                      (item) => item.symbol == stock.symbol)) {
                                    watchlistProvider
                                        .removeFromWatchlist(stock.symbol);
                                  } else {
                                    watchlistProvider.addToWatchlist(stock);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  watchlistProvider.watchlist.any((item) =>
                                          item.symbol ==
                                          stockProvider.stockDetails?.symbol)
                                      ? 'Remove from Watchlist'
                                      : 'Add to Watchlist',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),

            const Divider(),

          
            const Text(
              'Your Watchlist:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: watchlistProvider.watchlist.isEmpty
                  ? Center(
                      child: Text(
                        'Your watchlist is empty.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: watchlistProvider.watchlist.length,
                      itemBuilder: (context, index) {
                        return WatchlistItem(
                          stock: watchlistProvider.watchlist[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
