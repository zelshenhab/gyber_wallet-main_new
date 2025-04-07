import 'package:crypto_wallet/presentation/authentication/landing/cubit/auth_landing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/domain/repositories/phrase_repository.dart';
import 'package:crypto_wallet/presentation/authentication/landing/landing.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

// صفحة الدخول أو الصفحة الرئيسية للمصادقة
class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // تأكد من توفير الـ Cubit بواسطة BlocProvider
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<AuthLandingCubit, AuthLandingState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == AuthLandingStatus.failure) {
                context.showErrorMessage(state.errorMessage);
              } else if (state.status == AuthLandingStatus.success) {
                // تحديث الحالة إلى "النجاح" وعرض الصفحة التالية
                context.read<AppCubit>().updateWalletModel(state.walletModel);
                context.push(WalletPages.home);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/svg/logo.svg',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: context.minBlockVertical * 2),
                Text(
                  'Welcome Back!',
                  style: CsTextStyle.headline2.copyWith(
                    fontWeight: CsFontWeight.bold,
                  ),
                ),
                SizedBox(height: context.minBlockVertical * 7),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: CsTextStyle.overline.copyWith(),
                  ),
                ),
                SizedBox(height: context.minBlockVertical),
                // تأكد من أن `InputBox` هو عنصر صحيح أو استبداله بعنصر مناسب
                InputBox(
                  hintText: 'Enter your password',
                  onChanged: (password) {
                    // تحديث كلمة المرور
                    context.read<AuthLandingCubit>().onPasswordChanged(password);
                  },
                  isPassword: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.minBlockVertical * 5),
                BlocBuilder<AuthLandingCubit, AuthLandingState>(
                  builder: (context, state) {
                    return SolidButton(
                      text: 'Unlock',
                      onPressed: state.isValid
                          ? () => context.read<AuthLandingCubit>().onSubmitted()
                          : null,
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
