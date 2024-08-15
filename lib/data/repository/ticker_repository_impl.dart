import 'package:injectable/injectable.dart';
import 'package:tark_test/data/source/web_socket_source.dart';
import 'package:tark_test/domain/repository/tickers_repository.dart';

@LazySingleton(as: TickersRepository)
class TickerRepositoryImpl implements TickersRepository {
  final WebSocketSource _webSocketSource;

  TickerRepositoryImpl(this._webSocketSource);

  @override
  Stream tickersStream() => _webSocketSource.mainTickersStream;
}
