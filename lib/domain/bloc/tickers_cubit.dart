import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tark_test/domain/model/ticker.dart';
import 'package:tark_test/domain/repository/tickers_repository.dart';

@injectable
class TickersCubit extends Cubit<TickersState> {
  final TickersRepository tickersRepository;

  late final StreamSubscription _streamSubscription;

  TickersCubit(this.tickersRepository) : super(TickersInitialState()) {
    _streamSubscription = tickersRepository.tickersStream().listen(_streamListener);
  }

  void _streamListener(dynamic tickers) {
    if (state is TickersInitialState) {
      emit(TickersLoadingState());
    }
    if (state is TickersSuccessLoadingState) {
      final currentTickers = (state as TickersSuccessLoadingState).tickersList;
      for (final ticker in tickers as List<Ticker>) {
        currentTickers.removeWhere((e) => e.tickerName == ticker.tickerName);
        currentTickers.add(ticker);
        currentTickers.sort((a, b) => a.tickerName.compareTo(b.tickerName));
      }
      emit(
        TickersSuccessLoadingState(
          [...currentTickers],
        ),
      );
    } else {
      emit(TickersSuccessLoadingState([...tickers]));
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    super.close();
  }
}

///CubitState
sealed class TickersState {}

class TickersInitialState extends TickersState {}

class TickersLoadingState extends TickersState {}

class TickersSuccessLoadingState extends TickersState {
  final List<Ticker> tickersList;

  TickersSuccessLoadingState(this.tickersList);
}
