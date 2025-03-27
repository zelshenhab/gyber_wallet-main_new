import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/bootstrap.dart';
import 'package:crypto_wallet/data/repositories/repositories.dart';
import 'package:encrypt/encrypt.dart'; // استيراد مكتبة التشفير الجديدة
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Entry point of the application. The main function is asynchronous to
// allow the necessary components to initialize before launching the application.
Future<void> main() async {
  // Instance creation of the secure storage to safely store sensitive data.
  const storage = FlutterSecureStorage();

  // Creating an encryption key and IV for AES encryption.
  final key = Key.fromLength(32); // 32 بايت لمفتاح AES-256
  final iv = IV.fromLength(16); // 16 بايت IV

  // Initializing the Encrypter using AES
  final encrypter = Encrypter(AES(key));

  // Loading environment variables from the .env file for secure management
  await dotenv.load(fileName: 'assets/.env');

  // The bootstrap function initializes the application with the necessary dependencies.
  await bootstrap(
    () => App(
      phraseRepository: PhraseRepositoryImpl(storage: storage),
      contractRepository: ContractRepositoryImpl(),
    ),
  );
}
