/// Provides a set of standardized APIs for exchanges and trading markets.
library exchange;

import 'package:decimal/decimal.dart';

abstract class Exchange {
  Future<List<Token>> getTokens();
  Stream<List<MarketDepth>> getMarketDepth(String from, String to);
}

class Token {
  const Token({
    required this.id,
    required this.name,
    required this.symbol,
  });

  final String id;
  final String name;
  final String symbol;
}

class MarketDepth {
  const MarketDepth({
    required this.price,
    required this.volume,
  });

  final Decimal price;
  final Decimal volume;
}
