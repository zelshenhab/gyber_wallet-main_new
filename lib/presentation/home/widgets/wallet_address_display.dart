import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletAddressDisplay extends StatelessWidget {
  const WalletAddressDisplay({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    final shortAddress =
        '${address.substring(0, 6)}...${address.substring(address.length - 4)}';

    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: address));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address copied!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              shortAddress,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.copy, size: 16, color: Colors.white60),
          ],
        ),
      ),
    );
  }
}
