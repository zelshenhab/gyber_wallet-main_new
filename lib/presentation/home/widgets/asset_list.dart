import 'package:flutter/material.dart';
import 'asset_card.dart';

class AssetList extends StatelessWidget {
  const AssetList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return const AssetCard(
          tokenName: 'BNB (BEP20)',
          tokenPrice: '571.2',
          change: '+0.07%',
          tokenAmount: '0.000345648',
          tokenUsd: '0.19567',
        );
      },
    );
  }
}
