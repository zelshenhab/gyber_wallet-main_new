import 'package:crypto_wallet/app/app_router.dart';
import 'package:crypto_wallet/presentation/authentication/seed_phrase/seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeedPhrasePage extends StatefulWidget {
  const SeedPhrasePage({super.key});

  @override
  State<SeedPhrasePage> createState() => _SeedPhrasePageState();
}

class _SeedPhrasePageState extends State<SeedPhrasePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SeedPhraseCubit>().generateMnemonic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final seedCubit = context.watch<SeedPhraseCubit>();
    final mnemonics = seedCubit.state.mnemonics;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1C2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // ✅ العنوان العلوي
              Column(
                children: [
                  Text(
                    'Gyber',
                    style: const TextStyle(
                      fontFamily: 'Nico Moji',
                      fontSize: 62,
                      fontWeight: FontWeight.w600,
                      height: 64 / 52,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Wallet',
                    style: const TextStyle(
                      fontFamily: 'Nico Moji',
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      height: 64 / 40,
                      color: Color(0xFFD49D32),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ✅ التحذير
              const Text(
                'WARNING',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Save your recovery phrase',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              // ✅ المنيومنك في Grid
              Expanded(
                child: GridView.builder(
                  itemCount: mnemonics.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final word = mnemonics[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        word,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: 360,
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
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 190,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<SeedPhraseCubit>()
                              .clearSelectedMnemonics();
                          context.push(WalletPages.confirmSeedPhrase);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4C9010), // أخضر
                                Color(0xFF4D7DA9), // أزرق باهت
                              ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
