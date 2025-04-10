import 'package:crypto_wallet/app/app_router.dart';
import 'package:crypto_wallet/presentation/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmSeedPage extends StatelessWidget {
  const ConfirmSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SeedPhraseCubit>().state;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1C2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ العنوان
              Center(
                child: Text(
                  'Enter seed phrase to import wallet:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ الكلمات العشوائية
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: state.randomMnemonics.map((word) {
                  final isSelected = state.confirmMnemonics.contains(word);
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<SeedPhraseCubit>()
                          .addSelectedMnemonics(word);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                        color: isSelected
                            ? Colors.blueAccent.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      child: Text(
                        word,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // ✅ الكلمات المختارة داخل مربعات صفراء
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(12, (index) {
                  final word = index < state.confirmMnemonics.length
                      ? state.confirmMnemonics[index]
                      : '';
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFFFC107), // لون أصفر
                        width: 2,
                      ),
                    ),
                    child: Text(
                      word,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),

              const Spacer(),

              // ✅ زر Continue بنفس التنسيق
              Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF072B40),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment
                      .center, // ممكن تستخدم centerLeft أو centerRight حسب ما تحب
                  child: GestureDetector(
                    onTap: state.isMnemonicsValid
                        ? () {
                            context.push(
                              WalletPages.createPin,
                              args: state.mnemonics.join(' '),
                            );
                          }
                        : null,
                    child: Container(
                      width: 180, // ✅ هنا هيتطبق فعليًا
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4C9010), Color(0xFF4D7DA9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
