class StockModel {
  final String symbol;
  final String currentPrice;
  final String changeAmount;
  final String changePercent;
  final String marketCap;

  StockModel({
    required this.symbol,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercent,
    required this.marketCap,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['01. symbol'] ?? 'N/A',
      currentPrice: json['05. price'] ?? 'N/A',
      changeAmount: json['09. change'] ?? 'N/A',
      changePercent: json['10. change percent'] ?? 'N/A',
      marketCap: json['06. volume'] ?? 'N/A',
    );
  }
 
}
