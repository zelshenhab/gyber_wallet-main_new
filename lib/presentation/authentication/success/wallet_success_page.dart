import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/app/app_router.dart'; // تأكد أنك أضفت route لـ WalletPages.home

class WalletSuccessPage extends StatefulWidget {
  const WalletSuccessPage({super.key});

  @override
  State<WalletSuccessPage> createState() => _WalletSuccessPageState();
}

class _WalletSuccessPageState extends State<WalletSuccessPage> {
  @override
  void initState() {
    super.initState();
    // الانتقال بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(WalletPages.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041C2C),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF072B40),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/Frame 465.png', // تأكد من وجود هذا الأيقون في مجلد الصور
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Wallet imported\nsuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
