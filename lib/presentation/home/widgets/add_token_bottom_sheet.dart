import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTokenBottomSheet extends StatelessWidget {
  AddTokenBottomSheet({super.key});

  final _symbolController = TextEditingController();
  final _decimalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTokenCubit(
        contractRepository: context.read<ContractRepository>(),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F1C2E), // لون الخلفية الداكن
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Import Token',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Anyone can create a token, including fake versions of existing tokens.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              BlocBuilder<AddTokenCubit, AddTokenState>(
                builder: (context, state) {
                  return _buildInputField(
                    hintText: 'Contract Address',
                    onChanged:
                        context.read<AddTokenCubit>().onContractAddressChanged,
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<AddTokenCubit, AddTokenState>(
                listener: (context, state) {
                  if (state.status == AddTokenStatus.success) {
                    _symbolController.text = state.tokenSymbol;
                    _decimalController.text = state.tokenDecimal;
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildInputField(
                        controller: _symbolController,
                        hintText: 'Token Symbol',
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        controller: _decimalController,
                        hintText: 'Token Decimal',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D7DA9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Add Token',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    String? hintText,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white30),
        ),
      ),
    );
  }
}
