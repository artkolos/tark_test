class Ticker {
  final String tickerName;
  final String volume;
  final String open;
  final String close;

  const Ticker({
    required this.tickerName,
    required this.volume,
    required this.open,
    required this.close,
  });

  factory Ticker.fromMap(Map<String, dynamic> data) {
    return Ticker(
      tickerName: data['s'],
      volume: data['v'].toString(),
      open: data['o'].toString(),
      close: data['c'].toString(),
    );
  }

  @override
  String toString() {
    return 'Ticker{tickerName: $tickerName, volume: $volume, open: $open, close: $close}';
  }
}
