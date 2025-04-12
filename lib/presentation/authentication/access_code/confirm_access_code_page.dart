import 'package:flutter/material.dart';
import 'package:crypto_wallet/app/app_router.dart';

class ConfirmAccessCodePage extends StatefulWidget {
  const ConfirmAccessCodePage({super.key, required this.originalCode});

  final String originalCode; // الكود الذي تم إدخاله في الصفحة السابقة

  @override
  State<ConfirmAccessCodePage> createState() => _ConfirmAccessCodePageState();
}

class _ConfirmAccessCodePageState extends State<ConfirmAccessCodePage> {
  final TextEditingController _controller = TextEditingController();
  String _error = '';

  void _onConfirm() {
    if (_controller.text == widget.originalCode) {
      // ✅ الكود صحيح، انتقل إلى الصفحة التالية مثلاً:
      Navigator.of(context).pushReplacementNamed(WalletPages.success);
    } else {
      setState(() => _error = 'Access code does not match');
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Please confirm your access code',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF072B40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter access code',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (_error.isNotEmpty) ...[
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
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
                child: Center(
                  child: GestureDetector(
                    onTap: _onConfirm,
                    child: Container(
                      width: 180,
                      height: 55,
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
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
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
