import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/domain/repositories/contract_repository.dart';
import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:crypto_wallet/presentation/authentication/seed_phrase/cubit/seed_phrase_cubit.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.phraseRepository,
    required this.contractRepository,
  });

  final PhraseRepository phraseRepository;
  final ContractRepository contractRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PhraseRepository>(
          create: (_) => phraseRepository,
        ),
        RepositoryProvider<ContractRepository>(
          create: (_) => contractRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SeedPhraseCubit(
              phraseRepository: phraseRepository,
            ),
          ),
          BlocProvider(
            create: (context) => AppCubit(phraseRepository: phraseRepository),
          ),
        ],
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: CsColors.black),
        scaffoldBackgroundColor: CsColors.scaffold,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      // ],
      // supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: WalletPages.splash,
      // initialRoute: WalletPages.splash,
      onGenerateRoute: AppRouter.onRouteGenerate,
    );
  }
}
