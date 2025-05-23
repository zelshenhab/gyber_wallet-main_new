import 'dart:math';
import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seed_phrase_state.dart';

class SeedPhraseCubit extends Cubit<SeedPhraseState> {
  SeedPhraseCubit({required PhraseRepository phraseRepository})
      : _phraseRepository = phraseRepository,
        super(const SeedPhraseState());

  final PhraseRepository _phraseRepository;

  void generateMnemonic() {
    final mnemonic = _phraseRepository.getMnemonics();
    final mnemonics = mnemonic.toList;
    final randomMnemonics = [...mnemonics]..shuffle(Random.secure());

    emit(
      state.copyWith(
        mnemonics: mnemonics,
        randomMnemonics: randomMnemonics,
        mnemonicText: mnemonic, // ✅ تخزين النص الكامل هنا
      ),
    );
  }

  void addSelectedMnemonics(String text) {
    final currentSelectedMnemonics = List<String>.from(state.confirmMnemonics);
    if (state.confirmMnemonics.contains(text)) {
      currentSelectedMnemonics.remove(text);
    } else {
      currentSelectedMnemonics.add(text);
    }
    emit(
      state.copyWith(
        confirmMnemonics: currentSelectedMnemonics,
        isMnemonicsValid: false,
        status: SeedPhraseStatus.initial,
      ),
    );
    validateMnemonics();
  }

  void clearSelectedMnemonics() {
    emit(
      state.copyWith(
        confirmMnemonics: [],
        isMnemonicsValid: false,
        status: SeedPhraseStatus.initial,
      ),
    );
  }

  void validateMnemonics() {
    if (state.confirmMnemonics.length != 12) return;
    if (listEquals(state.mnemonics, state.confirmMnemonics)) {
      emit(
        state.copyWith(
          status: SeedPhraseStatus.success,
          isMnemonicsValid: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: SeedPhraseStatus.failure,
          errorMessage: 'Invalid Mnemonics',
          isMnemonicsValid: false,
        ),
      );
    }
  }
}

extension StringX on String {
  List<String> get toList => split(' ').toList();
}
