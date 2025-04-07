import 'package:crypto_wallet/app/view/app.dart';
import 'package:crypto_wallet/bootstrap.dart';
import 'package:crypto_wallet/data/repositories/contract_repository_impl.dart';
import 'package:crypto_wallet/data/repositories/phrase_repository_impl.dart';
import 'package:encrypt/encrypt.dart'
    as encrypt; // استخدم اسم مستعار لمكتبة التشفير
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  const storage = FlutterSecureStorage();

  // إنشاء مفتاح التشفير باستخدام الاسم المستعار
  final key = encrypt.Key.fromLength(32); // 32 بايت لمفتاح AES-256
  final iv = encrypt.IV.fromLength(16); // 16 بايت IV

  // تهيئة مكتبة التشفير
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // استخدام encrypter هنا (مثال لتشفير نص)
  final encrypted = encrypter.encrypt('secret data', iv: iv);

  // يمكنك استخدام هذه المتغيرات لاحقًا في تطبيقك
  if (kDebugMode) {
    print(encrypted.base64);
  } // طباعة النص المشفر

  // تحميل المتغيرات البيئية من ملف .env
  await dotenv.load(fileName: "assets/.env");

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
