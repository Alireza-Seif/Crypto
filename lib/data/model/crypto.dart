class Crypto {
  String id, name, symbol;
  double changePercent24hr, priceUsd, marketCapUsd;
  int rank;

  Crypto(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24hr,
    this.priceUsd,
    this.marketCapUsd,
    this.rank,
  );

  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject['id'],
      jsonMapObject['name'],
      jsonMapObject['symbol'],
      double.parse(jsonMapObject['changePercent24hr']),
      double.parse(jsonMapObject['priceUsd']),
      double.parse(jsonMapObject['marketCapUsd']),
      int.parse(jsonMapObject['rank']),
    );
  }
}
