import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tark_test/domain/bloc/filter_ticker_cubit.dart';
import 'package:tark_test/domain/bloc/tickers_cubit.dart';
import 'package:tark_test/injectable.dart';
import 'package:tark_test/presentation/main_screen/widgets/search_filed.dart';
import 'package:tark_test/presentation/main_screen/widgets/ticker_data_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  final FilterTickerCubit _filterTickerBloc = getIt.get<FilterTickerCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<TickersCubit>()),
        BlocProvider(create: (context) => _filterTickerBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(
            0xFF212630,
          ),
          appBar: AppBar(
            title: SearchFiled(
              textController: _textController,
              onChanged: (value) {
                _filterTickerBloc.searchTicker(value);
              },
            ),
            backgroundColor: const Color(
              0xFF212630,
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TickersCubit, TickersState>(
      builder: (context, state) {
        switch (state) {
          case TickersInitialState():
            return const Center(child: CircularProgressIndicator());
          case TickersLoadingState():
            return const Center(child: CircularProgressIndicator());
          case TickersSuccessLoadingState():
            final mainTickers = state.tickersList;
            return BlocBuilder<FilterTickerCubit, FilterTickerState>(
              builder: (context, state) {
                switch (state) {
                  case FilterTickerInitialState():
                    return mainTickers.length >= 4
                        ? ListView(
                            children: mainTickers
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 23,
                                    ),
                                    child: TickerDataWidget(
                                      ticker: e,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  case FilterTickerLoadingState():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case FilterTickerSuccessLoadingState():
                    return ListView(
                      children: state.tickers
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(
                                top: 23,
                              ),
                              child: TickerDataWidget(
                                ticker: e,
                              ),
                            ),
                          )
                          .toList(),
                    );
                }
              },
            );
        }
      },
    );
  }
}
