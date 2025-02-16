import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocksapp/models/stock.dart';

import '../providers/watchlist_provider.dart';

class WatchlistItem extends StatelessWidget {
  final StockModel stock;

  const WatchlistItem({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistProvider =
        Provider.of<WatchlistProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.withOpacity(0.1),
            Colors.blueGrey.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.indigo,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            Text(
              stock.symbol,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${stock.currentPrice}',
                  style: const TextStyle(fontSize: 16),
                ),
                


              ],
            ),
            Text(
  'Change: ${stock.changeAmount} (${stock.changePercent}%)',
  style: TextStyle(
    fontSize: 16,
  ),
),
            const SizedBox(height: 8),

          
            Text(
              'Market Cap: ${stock.marketCap ?? 'N/A'}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 16),

           
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  watchlistProvider.removeFromWatchlist(stock.symbol);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text('Remove'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
