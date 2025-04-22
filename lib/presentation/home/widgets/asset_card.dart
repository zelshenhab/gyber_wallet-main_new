import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.tokenName,
    required this.tokenPrice,
    required this.change,
    required this.tokenAmount,
    required this.tokenUsd,
  });

  final String tokenName;
  final String tokenPrice;
  final String change;
  final String tokenAmount;
  final String tokenUsd;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tokenName, style: const TextStyle(color: Colors.white)),
                Text('\$$tokenPrice • $change',
                    style: const TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tokenAmount, style: const TextStyle(color: Colors.white)),
              Text('\$$tokenUsd',
                  style: const TextStyle(color: Colors.white60, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
