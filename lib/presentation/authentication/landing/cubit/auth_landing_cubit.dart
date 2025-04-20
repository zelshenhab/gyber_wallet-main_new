import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:crypto_wallet/presentation/authentication/landing/cubit/auth_landing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLandingCubit extends Cubit<AuthLandingState> {
  AuthLandingCubit({required PhraseRepository phraseRepository})
      : _phraseRepository = phraseRepository,
        super(const AuthLandingState());

  final PhraseRepository _phraseRepository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
    isValid();
  }

  void isValid() {
    if (state.password.length == 6) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }

  Future<void> onSubmitted() async {
    try {
      final storedCode = await _secureStorage.read(key: 'access_code');

      if (storedCode == null) {
        emit(state.copyWith(
          status: AuthLandingStatus.failure,
          errorMessage: 'No access code found',
        ));
        return;
      }

      if (storedCode != state.password) {
        emit(state.copyWith(
          status: AuthLandingStatus.failure,
          errorMessage: 'Incorrect access code',
        ));
        return;
      }

      // ✅ إذا الكود صحيح - حاول تجيب بيانات المحفظة
      final response = await _phraseRepository.retrieveData(storedCode);
      if (response != null) {
        emit(state.copyWith(
          status: AuthLandingStatus.success,
          walletModel: response,
        ));
      } else {
        emit(state.copyWith(
          status: AuthLandingStatus.failure,
          errorMessage: 'Wallet not found, try again',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthLandingStatus.failure,
        errorMessage: 'Unexpected error occurred',
      ));
    }
  }
}
