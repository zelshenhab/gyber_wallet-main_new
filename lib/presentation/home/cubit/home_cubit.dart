import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PhraseRepository _phraseRepository;
  final ContractRepository _contractRepository;

  HomeCubit({
    required PhraseRepository phraseRepository,
    required ContractRepository contractRepository,
  })  : _phraseRepository = phraseRepository,
        _contractRepository = contractRepository,
        super(const HomeState()) {
    // تحديد قيمة البداية للـ ethBalance
    emit(state.copyWith(ethBalance: EtherAmount.zero()));
  }

  // استخدام _phraseRepository إذا كنت بحاجة له في المستقبل
  Future<void> getEthBalance(String publicKey) async {
    // تحويل EthereumAddress إلى String باستخدام hex
    final ethAddress =
        EthereumAddress.fromHex(publicKey).hex; // تحويل إلى String

    // استخدام await for للاشتراك في Stream
    await for (final data in _contractRepository.getEthBalance(ethAddress)) {
      emit(state.copyWith(ethBalance: data)); // تحديث حالة الرصيد بشكل صحيح
    }
  }

  @override
  Future<void> close() {
    _contractRepository.dispose();
    return super.close();
  }
}
