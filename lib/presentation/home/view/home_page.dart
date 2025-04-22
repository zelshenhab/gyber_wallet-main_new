import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_event.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:crypto_wallet/presentation/home/widgets/action_buttons_row.dart';
import 'package:crypto_wallet/presentation/home/widgets/bottom_indicator_bar.dart';
import 'package:crypto_wallet/presentation/home/widgets/asset_list.dart';
import 'package:crypto_wallet/presentation/home/widgets/balance_display.dart';
import 'package:crypto_wallet/presentation/home/widgets/home_app_bar.dart';
import 'package:crypto_wallet/presentation/home/widgets/wallet_address_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            contractRepository: context.read<ContractRepository>(),
          )..add(GetEthBalanceEvent(app.wallet.publicKey ?? '')),
        ),
        BlocProvider(
          create: (context) => AddTokenCubit(
            contractRepository: context.read<ContractRepository>(),
          ),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<AppCubit>().state.wallet;

    return Scaffold(
      backgroundColor: const Color(0xFF061421),
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const BalanceDisplay(),
            const SizedBox(height: 8),
            WalletAddressDisplay(address: wallet.publicKey ?? ''),
            const SizedBox(height: 24),
            const ActionButtonsRow(),
            const SizedBox(height: 24),
            const Expanded(child: AssetList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomIndicatorBar(
        currentIndex: 0, // أو أي رقم يمثل الشاشة الحالية
        onTap: (index) {
          // هنا تقدر تتنقل بين الصفحات أو تعمل setState
          if (kDebugMode) {
            print("Tapped on index: $index");
          }
        },
      ),
    );
  }
}
