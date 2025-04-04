import 'package:encrypt/encrypt.dart';

/// Encrytion
String encryption(String password, String key) {
  final aesKey = Key.fromUtf8(key.padRight(32)); // Ensure key length
  final encrypter = Encrypter(AES(aesKey, mode: AESMode.ecb));
  final encrypted = encrypter.encrypt(password); // Encrypt password
  return encrypted.base64;  // Return Base64-encoded string
}

/// Decryption
String decryption(String encryptedText, String key) {
  // Ensure the key is 32 bytes
  final aesKey = Key.fromUtf8(key.length == 32 ? key : key.padRight(32));

  final encrypter = Encrypter(AES(aesKey, mode: AESMode.ecb)); // Use ECB mode
  try {
    final decrypted = encrypter.decrypt64(encryptedText);  // Decrypt Base64 string
    return decrypted;
  } catch (e) {
    throw Exception(e);
  }
}
