import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart'; // تغيير اسم الفئة Key باستخدام بادئة

Future<void> main() async {
  // إنشاء مفتاح التشفير
  final key = encrypt.Key.fromLength(32); // الآن نستخدم Key من مكتبة encrypt
  final iv = encrypt.IV.fromLength(16); // نفس الشيء هنا

  // تهيئة مكتبة التشفير
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // استخدام التشفير
  final encrypted = encrypter.encrypt('secret data', iv: iv);

  if (kDebugMode) {
    print('Encrypted data: ${encrypted.base64}');
  }

  // باقي الكود الخاص بتشغيل التطبيق
}
