// Importing necessary dependencies and libraries
import 'dart:io';

import 'package:crypto_wallet/presentation/authentication/access_code/access_code_page.dart';
import 'package:crypto_wallet/presentation/authentication/access_code/confirm_access_code_page.dart';
import 'package:crypto_wallet/presentation/authentication/authentication.dart';
import 'package:crypto_wallet/presentation/authentication/fingerprint_auth/fingerprint_auth_page.dart';
import 'package:crypto_wallet/presentation/authentication/success/wallet_success_page.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:crypto_wallet/presentation/landing/view/splash_page.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Class containing constants representing the various routes available in the application.
class WalletPages {
  static const String splash = '/';
  static const String createWallet = '/auth/create/wallet';
  static const String authLanding = '/auth/landing';
  static const String createPin = '/auth/create/pin';
  static const String import = '/auth/import/wallet';
  static const String seedPhrase = '/auth/seedPhrase';
  static const String home = '/home';
  static const String confirmSeedPhrase = '/auth/confirmSeedPhrase';
  static const String fingerprintAuth =
      '/auth/fingerprint'; // Added fingerprintAuth page
  static const String accessCode = '/auth/accessCode';
  static const String confirmAccessCode = '/auth/access/confirm';
  static const String success = '/auth/success';
}

// Class handling the routing logic in the application.
class AppRouter {
  // Method to handle the generation of routes based on the route settings.
  static Route<dynamic> onRouteGenerate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case WalletPages.splash:
        return platformPageRoute<dynamic>(builder: (_) => const SplashPage());
      case WalletPages.createWallet:
        return platformPageRoute<dynamic>(
            builder: (_) => const CreateWalletPage());
      case WalletPages.authLanding:
        return platformPageRoute<dynamic>(
            builder: (_) => const AuthLandingPage());
      case WalletPages.createPin:
        return platformPageRoute<dynamic>(
            builder: (_) => CreatePinPage(mnemonics: args as String),
            fullscreenDialog: true);
      case WalletPages.import:
        return platformPageRoute<dynamic>(builder: (_) => ImportWalletPage());
      case WalletPages.seedPhrase:
        return platformPageRoute<dynamic>(
            builder: (_) => const SeedPhrasePage());
      case WalletPages.home:
        return platformPageRoute<dynamic>(builder: (_) => const HomePage());
      case WalletPages.confirmSeedPhrase:
        return platformPageRoute<dynamic>(
            builder: (_) => const ConfirmSeedPage());
      case WalletPages
            .fingerprintAuth: // Added new route for Fingerprint/Face ID page
        return platformPageRoute<dynamic>(
            builder: (_) => const FingerprintPage());
      case WalletPages.accessCode:
        return platformPageRoute<dynamic>(
          builder: (_) => const AccessCodePage(),
        );
      case WalletPages.confirmAccessCode:
        return platformPageRoute<dynamic>(
          builder: (_) => ConfirmAccessCodePage(),
        );
      case WalletPages.success:
        return platformPageRoute(
          builder: (_) => const WalletSuccessPage(),
        );

      default:
        return platformPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child:
                  Text('Oops you lost your ways', style: CsTextStyle.bodyText1),
            ),
          ),
        );
    }
  }

  // Method to determine the type of route page (Cupertino or Material) based on the platform (iOS or Android).
  static PageRoute<T> platformPageRoute<T>({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
    String? iosTitle,
  }) {
    if (Platform.isMacOS) {
      return CupertinoPageRoute<T>(
        builder: builder,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        title: iosTitle,
      );
    } else if (Platform.isAndroid) {
      return MaterialPageRoute<T>(
        builder: builder,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    } else {
      return CupertinoPageRoute<T>(
        builder: builder,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        title: iosTitle,
      );
    }
  }
}

// Extension providing utilities for navigation within the application, offering methods to replace the current route, clear the navigation stack, etc.
extension AppRouteX on BuildContext {
  void replace(String routeName) =>
      Navigator.pushReplacementNamed(this, routeName);
  void popAll(String routeName) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  Future<void> pushAndClear(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page),
        (route) => false,
      );
  void push(String routeName, {Object? args}) =>
      Navigator.pushNamed(this, routeName, arguments: args);
  void offAndGo(String routeName, {Object? args}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: args);
}
