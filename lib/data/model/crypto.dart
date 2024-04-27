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
      jsonMapObject['changePercent24hr'],
      jsonMapObject['priceUsd'],
      jsonMapObject['marketCapUsd'],
      jsonMapObject['rank'],
    );
  }
}
