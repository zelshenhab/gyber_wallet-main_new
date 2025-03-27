import 'package:crypto_wallet/app/app.dart';
import 'package:crypto_wallet/bootstrap.dart';
import 'package:crypto_wallet/data/repositories/repositories.dart';
import 'package:encrypt/encrypt.dart'; // استيراد مكتبة التشفير الجديدة
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  const storage = FlutterSecureStorage();

  // إنشاء مفتاح التشفير
  final key = Key.fromLength(32); // 32 بايت لمفتاح AES-256
  final iv = IV.fromLength(16); // 16 بايت IV

  // تهيئة مكتبة التشفير
  final encrypter = Encrypter(AES(key));

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
