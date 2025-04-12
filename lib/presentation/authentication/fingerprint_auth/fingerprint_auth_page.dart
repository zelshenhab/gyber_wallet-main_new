import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:crypto_wallet/app/app_router.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({super.key});

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool isFaceID = false;
  String _authStatus = 'Please authenticate';

  Future<void> _authenticate() async {
    try {
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final availableBiometrics = await _localAuth.getAvailableBiometrics();

      if (kDebugMode) {
        print('Supported: $isDeviceSupported');
      }
      if (kDebugMode) {
        print('Can check: $canCheckBiometrics');
      }
      if (kDebugMode) {
        print('Available biometrics: $availableBiometrics');
      }

      if (isDeviceSupported && canCheckBiometrics) {
        final authenticated = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to continue',
          options: const AuthenticationOptions(stickyAuth: true),
        );

        if (kDebugMode) {
          print('Authenticated: $authenticated');
        }

        if (authenticated) {
          Navigator.of(context).pushNamed(WalletPages.home);
        } else {
          setState(() => _authStatus = 'Failed to authenticate');
        }
      } else {
        setState(() => _authStatus = 'Biometrics not available');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Auth error: $e');
      }
      setState(() => _authStatus = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF041C2C);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          isFaceID ? 'Face detection' : 'Fingerprint authentication',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon:
              const Icon(Icons.navigate_before, color: Colors.white, size: 40),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF072B40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFaceID = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !isFaceID ? Colors.blue : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Fingerprint',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isFaceID = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isFaceID ? Colors.blue : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Face ID',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  isFaceID ? 'Face detection' : 'Fingerprint authentication',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  isFaceID
                      ? 'assets/icons/FaceID.png'
                      : 'assets/icons/FINGER.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  isFaceID ? 'Look at camera' : 'Fingerprint authentication',
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: _authenticate,
                child: Container(
                  width: double.infinity,
                  height: 80,
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
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 180,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3691E9), Color(0xFF4D7DA9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'CONFIRM',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
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
