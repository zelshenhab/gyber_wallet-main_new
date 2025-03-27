import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/bootstrap.dart';
import 'package:crypto_wallet/data/repositories/repositories.dart';
import 'package:encrypt/encrypt.dart'; // استيراد مكتبة encrypt
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  const storage = FlutterSecureStorage();

  // إعداد مفتاح التشفير والتشفير باستخدام مكتبة encrypt
  final key = Key.fromLength(32); // مفتاح بطول 32 بايت (256-bit)
  final iv = IV.fromLength(16); // IV بطول 16 بايت
  final encrypter = Encrypter(AES(key));

  // تحميل المتغيرات البيئية من ملف .env
  await dotenv.load(fileName: 'assets/.env');

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
