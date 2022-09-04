/// Provides a set of standardized APIs for exchanges and trading markets.
library exchange;

import 'package:decimal/decimal.dart';

abstract class Exchange {
  const Exchange();

  Stream<List<Market>> getMarketsStream();
  Future<List<Asset>> getAssets();
  Stream<List<PriceVolume>> getMarketDepth(Market market);
  Stream<OrderBook> getMarketOrderBookStream(Market market);
  Stream<MarketStat> getMarketStatStream(Market market);
}

class Asset {
  const Asset({
    required this.id,
    required this.name,
    required this.symbol,
  });

  final String id;
  final String name;
  final String symbol;
}

class Market {
  const Market({
    required this.from,
    required this.to,
    this.stat,
  });

  final Asset from;
  final Asset to;

  final MarketStat? stat;
}

class PriceVolume {
  const PriceVolume({
    required this.price,
    required this.volume,
  });

  final Decimal price;
  final Decimal volume;
}

class OrderBook {
  const OrderBook({
    required this.asks,
    required this.bids,
  });

  final List<PriceVolume> asks;
  final List<PriceVolume> bids;
}

class MarketStat {
  const MarketStat({
    required this.closed,
    this.bestSell,
    this.bestBuy,
    this.volumeSrc,
    this.volumeDst,
    this.latest,
    this.low,
    this.high,
    this.open,
    this.close,
    this.change,
  });

  final bool closed;
  final Decimal? bestSell;
  final Decimal? bestBuy;
  final Decimal? volumeSrc;
  final Decimal? volumeDst;
  final Decimal? latest;
  final Decimal? low;
  final Decimal? high;
  final Decimal? open;
  final Decimal? close;
  final Decimal? change;
}
