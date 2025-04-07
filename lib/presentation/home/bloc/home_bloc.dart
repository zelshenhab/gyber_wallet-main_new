import 'dart:async';

import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_event.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';



class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required ContractRepository contractRepository})
      : _contractRepository = contractRepository,
        super( HomeState()) {
    on<GetEthBalanceEvent>(_onGetEthBalance);
  }

  final ContractRepository _contractRepository;

  Future<void> _onGetEthBalance(
    GetEthBalanceEvent event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach(
      _contractRepository.getEthBalance(event.publicKey),
      onData: (EtherAmount data) => state.copyWith(ethBalance: data),
    );
  }
}
