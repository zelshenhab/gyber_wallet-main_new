import 'dart:async';

import 'package:crypto_wallet/domain/models/wallet_model.dart';
import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required PhraseRepository phraseRepository})
      : _phraseRepository = phraseRepository,
        super(const AppState()) {
    _streamSubscription = _phraseRepository.status.listen(updateAuthStatus);
  }

  late final StreamSubscription _streamSubscription;
  final PhraseRepository _phraseRepository;

  void updateWalletModel(WalletModel walletModel) {
    if (kDebugMode) {
      print('🔑 Wallet Address: ${walletModel.publicKey}');
    }
    emit(state.copyWith(wallet: walletModel));
  }

  void updateAuthStatus(AuthStatus status) {
    emit(state.copyWith(authStatus: status));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
