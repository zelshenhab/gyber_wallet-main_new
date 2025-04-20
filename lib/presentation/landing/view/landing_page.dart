import 'package:crypto_wallet/app/app.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C2E), // ← لون الخلفية هنا
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ عنوان Gyber + Wallet
                Column(
                  children: [
                    Text(
                      'Gyber',
                      style: const TextStyle(
                        fontFamily: 'Nico Moji',
                        fontWeight: FontWeight.w600,
                        fontSize: 62,
                        height: 64 / 52,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Wallet',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Nico Moji',
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        height: 64 / 40,
                        letterSpacing: 0,
                        color: Color(0xFFD49D32),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.minBlockVertical * 25),

                // ✅ زر Create Wallet
                Container(
                  width: 340,
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF072B40),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: GestureDetector(
                          onTap: () => context.push(WalletPages.seedPhrase),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4A4B08), // اللون الأخضر الداكن
                                  Color(
                                      0xFFA46B17), // اللون البرتقالي المائل للبني
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'CREATE NEW',
                              style: TextStyle(
                                fontSize: 20,
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

                const SizedBox(height: 30),

                // ✅ نص الدخول السفلي
                GestureDetector(
                  onTap: () => context.push(WalletPages.import),
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
