import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:crypto_wallet/presentation/authentication/create_pin/create_pin.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({super.key, required this.mnemonics});

  final String mnemonics;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePinCubit(
        phraseRepository: context.read<PhraseRepository>(),
      ),
      child: CreatePinView(mnemonics: mnemonics),
    );
  }
}

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key, required this.mnemonics});

  final String mnemonics;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF041C2C); // خلفية الشاشة و AppBar

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Create your password',
          style: TextStyle(
            color: Color(0xFFD49D32),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.back(),
          icon: const Icon(
            Icons.navigate_before,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocListener<CreatePinCubit, CreatePinState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CreatePinStatus.failure) {
                context.showErrorMessage('Oops an error occurred, Try again');
              } else if (state.status == CreatePinStatus.success) {
                context.read<AppCubit>().updateWalletModel(state.walletModel);
                // عند النجاح في التحقق من كلمة المرور، الانتقال إلى صفحة البصمة
                context
                    .push(WalletPages.accessCode); // توجيه إلى صفحة Fingerprint
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'The password must be at least\n8 characters to be secure',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Enter your new password',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                CustomInputBox(
                  isPassword: true,
                  onChanged: context.read<CreatePinCubit>().onPasswordChanged,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirm password',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                BlocBuilder<CreatePinCubit, CreatePinState>(
                  builder: (context, state) {
                    return CustomInputBox(
                      isPassword: true,
                      onChanged: context
                          .read<CreatePinCubit>()
                          .onConfirmPasswordChanged,
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<CreatePinCubit, CreatePinState>(
                  builder: (context, state) {
                    return Container(
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
                        alignment: Alignment.center, // وسط البطاقة
                        child: GestureDetector(
                          onTap: state.isValid
                              ? () =>
                                  context.read<CreatePinCubit>().getUserKeys(
                                        mnemonics,
                                        state.password,
                                      )
                              : null,
                          child: Container(
                            width: 170, // ← تحكم هنا في حجم الزر
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4C9010),
                                  Color(0xFF4D7DA9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'CONTINUE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputBox extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomInputBox({
    super.key,
    this.isPassword = false,
    this.hintText = '',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF0074D9), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF0074D9), width: 2.5),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
