import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:crypto_wallet/presentation/authentication/landing/cubit/auth_landing_cubit.dart';
import 'package:crypto_wallet/presentation/authentication/landing/cubit/auth_landing_state.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthLandingCubit(phraseRepository: context.read<PhraseRepository>()),
      child: const AuthLandingView(),
    );
  }
}

class AuthLandingView extends StatelessWidget {
  const AuthLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041C2C),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF041C2C),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: BlocListener<AuthLandingCubit, AuthLandingState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == AuthLandingStatus.failure) {
                    context.showErrorMessage(state.errorMessage);
                  } else if (state.status == AuthLandingStatus.success) {
                    context
                        .read<AppCubit>()
                        .updateWalletModel(state.walletModel);
                    context.push(WalletPages.home);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Gyber',
                            style: TextStyle(
                              fontFamily: 'Nico Moji',
                              fontWeight: FontWeight.w600,
                              fontSize: 62,
                              height: 64 / 52,
                              letterSpacing: 0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Wallet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nico Moji',
                              fontWeight: FontWeight.w600,
                              fontSize: 50,
                              height: 64 / 40,
                              letterSpacing: 0,
                              color: Color(0xFFD49D32),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Welcome back',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Enter your 6-digit access code',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 6,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => context
                          .read<AuthLandingCubit>()
                          .onPasswordChanged(value),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '******',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF072B40),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 200),
                    BlocBuilder<AuthLandingCubit, AuthLandingState>(
                      builder: (context, state) {
                        return Container(
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: state.isValid
                                    ? () => context
                                        .read<AuthLandingCubit>()
                                        .onSubmitted()
                                    : null,
                                child: Container(
                                  width: 160,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF4C9010),
                                        Color(0xFF4D7DA9)
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
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
        ),
      ),
    );
  }
}
