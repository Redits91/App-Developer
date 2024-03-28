import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt_package;
import 'package:crypto/crypto.dart';

class AESCrypt {
  static const String AES_MODE = 'aes-cbc';
  static const String CHARSET = 'UTF-8';
  static const String HASH_ALGORITHM = 'SHA-256';
  static final Uint8List ivBytes = Uint8List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

  static encrypt_package.Key generateKey(String password) {
    final keyBytes = utf8.encode(password);
    final hashBytes = sha256.convert(keyBytes).bytes;
    final Uint8List hashUint8List = Uint8List.fromList(hashBytes); // Convert List<int> to Uint8List
    return encrypt_package.Key(hashUint8List);
  }

  static String encrypt(String password, String message) {
    final key = generateKey(password);
    final encrypter = encrypt_package.Encrypter(encrypt_package.AES(key, mode: encrypt_package.AESMode.cbc));
    final encrypted = encrypter.encrypt(message, iv: encrypt_package.IV(ivBytes));
    return base64.encode(encrypted.bytes);
  }

  static String decrypt(String password, String base64EncodedCipherText) {
    final key = generateKey(password);
    final encrypter = encrypt_package.Encrypter(encrypt_package.AES(key, mode: encrypt_package.AESMode.cbc));
    final decrypted = encrypter.decrypt64(base64EncodedCipherText, iv: encrypt_package.IV(ivBytes));
    return decrypted;
  }
}
