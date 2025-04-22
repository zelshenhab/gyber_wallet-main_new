import 'package:crypto_wallet/presentation/home/widgets/send_bottom_sheet.dart';
import 'package:crypto_wallet/presentation/home/widgets/swap_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'action_button.dart';
import 'add_token_bottom_sheet.dart'; // تأكد من استيراد الملف

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.add,
          label: 'Add Token',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (_) => AddTokenBottomSheet(),
            );
          },
        ),
        ActionButton(
          icon: Icons.call_made,
          label: 'Send',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (_) => SendBottomSheet(),
            );
          },
        ),
        // const ActionButton(icon: Icons.call_made, label: 'Send'),
        const ActionButton(icon: Icons.call_received, label: 'Send'),

        ActionButton(
          icon: Icons.swap_horiz,
          label: 'Exchange',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (_) => SwapBottomSheet(),
            );
          },
        ),
        // const ActionButton(icon: Icons.swap_horiz, label: 'Exchange'),
      ],
    );
  }
}
