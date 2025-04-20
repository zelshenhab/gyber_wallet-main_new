import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto_wallet/app/app_router.dart';

class AccessCodePage extends StatefulWidget {
  const AccessCodePage({super.key});

  @override
  State<AccessCodePage> createState() => _AccessCodePageState();
}

class _AccessCodePageState extends State<AccessCodePage> {
  final List<String> _input = [];
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void _onKeyPressed(String value) {
    if (_input.length < 6) {
      setState(() => _input.add(value));
    }
  }

  void _onDelete() {
    if (_input.isNotEmpty) {
      setState(() => _input.removeLast());
    }
  }

  void _submitCode() async {
    if (_input.length == 6) {
      final accessCode = _input.join();

      await _secureStorage.write(key: 'access_code', value: accessCode);

      if (kDebugMode) {
        print('Saved PIN: $accessCode');
      }

      Navigator.of(context).pushNamed(
        WalletPages.confirmAccessCode,
        arguments: accessCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041C2C),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF041C2C),
        centerTitle: true,
        title: const Text(
          'Access Code',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'This code will be used\nto unlock your wallet',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _input.length ? Colors.blue : Colors.white24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Container(
              width: 320,
              height: 80,
              padding: const EdgeInsets.all(8),
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
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _submitCode,
                  child: Container(
                    width: 180,
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
                      'CREATE WALLET',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            _buildKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: keys.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 60,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) {
          final key = keys[index];
          return key == ''
              ? const SizedBox()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF041C2C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () =>
                      key == '⌫' ? _onDelete() : _onKeyPressed(key),
                  child: Text(
                    key,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
        },
      ),
    );
  }
}
