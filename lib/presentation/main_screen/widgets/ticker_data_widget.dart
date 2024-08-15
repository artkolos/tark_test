import 'package:flutter/material.dart';
import 'package:tark_test/domain/model/ticker.dart';
import 'package:tark_test/presentation/common/fonts.dart';

class TickerDataWidget extends StatelessWidget {
  const TickerDataWidget({
    super.key,
    required this.ticker,
  });

  final Ticker ticker;

  @override
  Widget build(BuildContext context) {
    final difference = (((double.tryParse(ticker.close) ?? 0) - (double.tryParse(ticker.open) ?? 0)) /
            (double.tryParse(ticker.open) ?? 1)) *
        100;
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ticker.tickerName.substring(0, 3),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: AppFonts.TITILLIUM_WEB,
                    ),
                  ),
                  Text(
                    '/${ticker.tickerName.substring(3)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0x66FFFFFF),
                      fontFamily: AppFonts.TITILLIUM_WEB,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              Text(
                'Vol ${double.tryParse(ticker.close)?.toStringAsFixed(1).replaceAll('.', ',') ?? ''}M',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.BARLOW,
                  fontWeight: FontWeight.w500,
                  color: Color(0x66FFFFFF),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                double.tryParse(ticker.close)?.toStringAsFixed(2).replaceAll('.', ',') ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.BARLOW,
                  color: difference >= 0 ? const Color(0xFF2DBD85) : const Color(0xFFE44358),
                ),
              ),
              Text(
                '${double.tryParse(ticker.close)?.toStringAsFixed(3).replaceAll('.', ',') ?? ''}\$',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.BARLOW,
                  color: Color(0x66FFFFFF),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 103,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: difference >= 0 ? const Color(0xFF2DBD85) : const Color(0xFFE44358),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            difference >= 0
                ? '+${difference.toStringAsFixed(2).replaceAll('.', ',')} %'
                : '${difference.toStringAsFixed(2).replaceAll('.', ',')} %',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: AppFonts.BARLOW,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
