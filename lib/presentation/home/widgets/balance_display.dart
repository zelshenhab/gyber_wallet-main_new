import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_state.dart';

class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final BigInt wei = state.ethBalance?.getInWei ?? BigInt.zero;
        final eth = (wei / BigInt.from(pow(10, 18))).toStringAsFixed(4);

        return Column(
          children: [
            Text(
              '$eth BTC',
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '65 M \$',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        );
      },
    );
  }
}
