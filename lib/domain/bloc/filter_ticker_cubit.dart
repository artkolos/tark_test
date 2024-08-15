import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tark_test/domain/model/ticker.dart';
import 'package:tark_test/domain/repository/tickers_repository.dart';

@injectable
class FilterTickerCubit extends Cubit<FilterTickerState> {
  final TickersRepository tickersRepository;

  final List<Ticker> _foundTickers = List.empty(growable: true);

  String _search = '';

  late final StreamSubscription _streamSubscription;

  FilterTickerCubit(this.tickersRepository) : super(FilterTickerInitialState()) {
    _streamSubscription = tickersRepository.tickersStream().listen(_streamListener);
  }

  void searchTicker(String search) => _search = search;

  void _streamListener(dynamic data) {
    if (_search.isEmpty) {
      _foundTickers.clear();
      emit(FilterTickerInitialState());
    } else {
      final List<Ticker> tickers = data;
      for (final ticker in tickers) {
        if (ticker.tickerName.contains(_search.toUpperCase())) {
          if (state is FilterTickerSuccessLoadingState) {
            _foundTickers.removeWhere((e) => ticker.tickerName == e.tickerName);
            _foundTickers.sort((a, b) => a.tickerName.compareTo(b.tickerName));
            _foundTickers.add(ticker);
          } else {
            _foundTickers.add(ticker);
          }
        }
      }
      emit(FilterTickerSuccessLoadingState([..._foundTickers]));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}

///BlocState
sealed class FilterTickerState {}

class FilterTickerInitialState extends FilterTickerState {}

class FilterTickerLoadingState extends FilterTickerState {}

class FilterTickerSuccessLoadingState extends FilterTickerState {
  final List<Ticker> tickers;

  FilterTickerSuccessLoadingState(this.tickers);
}
