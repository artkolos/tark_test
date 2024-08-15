import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tark_test/domain/model/ticker.dart';
import 'package:web_socket_channel/io.dart';

@singleton
class WebSocketSource {
  static const String _XRPUSDT = 'XRPUSDT';
  static const String _BNBUSDT = 'BNBUSDT';
  static const String _ETHUSDT = 'ETHUSDT';
  static const String _BTCUSDT = 'BTCUSDT';
  static const String _URI = 'wss://stream.binance.com:9443/ws/!miniTicker@arr';

  final StreamController<List<Ticker>> _tickers = StreamController.broadcast();

  Stream get mainTickersStream => _tickers.stream;

  final _channel = IOWebSocketChannel.connect(_URI);

  WebSocketSource() {
    _getTickers();
  }

  Future<void> _getTickers() async {
    await _channel.ready;
    _channel.stream.listen(
      (data) {
        final List<Ticker> mainTickers = List.empty(growable: true);
        final List<Map<String, dynamic>> mapTickers =
            (jsonDecode(data) as List<dynamic>).map((e) => e as Map<String, dynamic>).toList();
        for (final mapTicker in mapTickers) {
          final tickerName = mapTicker['s'];
          if (tickerName == _XRPUSDT || tickerName == _BNBUSDT || tickerName == _ETHUSDT || tickerName == _BTCUSDT) {
            mainTickers.add(Ticker.fromMap(mapTicker));
          }
        }
        _tickers.add(mainTickers);
      },
    );
  }
}
