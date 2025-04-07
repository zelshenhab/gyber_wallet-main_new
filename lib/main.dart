import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // تأكد من تشغيل MyApp كجزء من التطبيق.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(child: Text('Welcome to the Crypto Wallet!')),
      ),
    );
  }
}
