import 'package:crypto_wallet/app/view/app.dart';
import 'package:crypto_wallet/bootstrap.dart';
import 'package:crypto_wallet/data/repositories/contract_repository_impl.dart';
import 'package:crypto_wallet/data/repositories/phrase_repository_impl.dart';
import 'package:encrypt/encrypt.dart'
    as encrypt; // استخدام بادئة للمكتبة الخاصة بالتشفير
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // أو أي مكتبة أخرى تستخدم Key من Flutter

Future<void> main() async {
  const storage = FlutterSecureStorage();

  // إنشاء مفتاح التشفير باستخدام بادئة 'encrypt'
  final key = encrypt.Key.fromLength(32); // 32 بايت لمفتاح AES-256
  final iv = encrypt.IV.fromLength(16); // 16 بايت IV

  // تهيئة مكتبة التشفير
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // تشفير النص باستخدام التشفير الذي تم تهيئته
  final encrypted = encrypter.encrypt('your_data_here', iv: iv);

  // طباعة النص المشفر (أو استخدامه لاحقًا)
  if (kDebugMode) {
    print('Encrypted Text: ${encrypted.base64}');
  }

  // تحميل المتغيرات البيئية من ملف .env
  await dotenv.load(fileName: 'assets/.env.dev');

  // تشغيل التطبيق مع المستودعات المحدثة
  await bootstrap(
    () => App(
      phraseRepository: PhraseRepositoryImpl(storage: storage),
      contractRepository: ContractRepositoryImpl(
        phraseRepository: PhraseRepositoryImpl(storage: storage),
      ),
    ),
  );
}
