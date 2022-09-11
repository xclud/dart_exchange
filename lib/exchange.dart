/// Provides a set of standardized APIs for exchanges and trading markets.
library exchange;

import 'package:decimal/decimal.dart';

abstract class MarketStream {
  MarketStream(this.market);

  final Market market;

  final latestDeals = <MarketTrade>[];
  final latestBids = <MarketDepthItem>[];
  final latestAsks = <MarketDepthItem>[];

  Stream<List<MarketTrade>> get deals;
  Stream<MarketDepth> get depths;
}

abstract class Exchange {
  const Exchange();

  String get name;

  MarketStream getMarket(Market market);

  Stream<List<Market>> getMarketsStream();
  Future<List<Asset>> getAssets();

  @Deprecated('')
  Stream<MarketDepth> getMarketDepth(Market market);
  Stream<MarketStat> getMarketStatStream(Market market);
  Future<List<OrderType>> getSupportedOrderTypes(Market market);

  @Deprecated('')
  Stream<List<MarketTrade>> getMarketTradesStream(Market market);

  Future<List<Candle>> getCandles({
    required Market market,
    required DateTime start,
    required DateTime end,
    required Duration resolution,
  });
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

class MarketDepthItem {
  const MarketDepthItem({
    required this.price,
    required this.volume,
    required this.total,
  });

  final Decimal price;
  final Decimal volume;
  final Decimal total;
}

class MarketDepth {
  const MarketDepth({
    required this.asks,
    required this.bids,
  });

  final List<MarketDepthItem> asks;
  final List<MarketDepthItem> bids;
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

enum OrderType {
  limit,
  market,
  stopLimit,
  stopLoss,
  trail,
}

class MarketTrade {
  const MarketTrade({
    required this.price,
    required this.volume,
    required this.timestamp,
  });

  final Decimal price;
  final Decimal volume;
  final DateTime timestamp;
}

class Candle {
  const Candle({
    required this.time,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.volume,
  });

  final int time;
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;
}
