// import 'dart:typed_data';
// // import 'package:steel_crypt/src/satellites/satellite.dart';


// // import 'package:steel_crypt/PointyCastleN/export.dart';

// // import 'package:encrypt/encrypt.dart' as encrypt;

// // ignore: avoid_classes_with_only_static_members
// // class MyEncryptionDecryption {
//   class AesGcm {
//   Uint8List _key32;

//   AesGcm(this._key32);

//   String encrypt(String input, [Uint8List iv]) {
//     CipherParameters params = PaddedBlockCipherParameters(
//         ParametersWithIV<KeyParameter>(KeyParameter(_key32), iv), null);
//     PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
//     cipher..init(true, params);
//     Uint8List inter = cipher.process(utf8.encode(input) as Uint8List);
//     return base64.encode(inter);
//   }

//   String decrypt(String encrypted, [Uint8List iv]) {
//     CipherParameters params = PaddedBlockCipherParameters(
//         ParametersWithIV(KeyParameter(_key32), iv), null);
//     PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
//     cipher..init(false, params);
//     Uint8List inter = cipher.process(base64.decode(encrypted));
//     return utf8.decode(inter);
//   }

//   // static encryptData() async {

//   // final message = <int>[1,2,3];

//   // final algorithm = AesGcm.with256bits();
//   // final secretKey = await algorithm.newSecretKey();
//   // final nonce = algorithm.newNonce();

//   // // Encrypt
//   // final secretBox = await algorithm.encrypt(
//   //   message,
//   //   secretKey: secretKey,
//   //   nonce: nonce,
//   // );
//   // print('Nonce: ${secretBox.nonce}');
//   // print('Ciphertext: ${secretBox.cipherText}');
//   // print('MAC: ${secretBox.mac.bytes}');

//   // // Decrypt
//   // // final clearText = await algorithm.encrypt(
//   // //   secretBox,
//   // //   secretKey: secretKey,
//   // // );
//   // // print('Cleartext: $clearText');


//   // }


// // Uint8List plaintext  = utf8.encode("Mayur, You got it!");
// // Uint8List iv = AesGcm.with128bits().newNonce();
// // Uint8List passphrase = utf8.encode('Test!ng012345678');
// // SecretKey secretKey = new SecretKey(passphrase);

// // SecretBox secretBox = await AesGcm.with128bits().encrypt(plaintext, nonce: iv, secretKey: secretKey);
// // String ivCiphertextMacB64 = base64.encode(secretBox.concatenation()); // Base64 encoding of: IV | ciphertext | MAC
// // print("ivCiphertextMacB64 : " + ivCiphertextMacB64);

//   //For AES Encryption/Decryption
//   // static final key = encrypt.Key.fromLength(32);
//   // static final iv = encrypt.IV.fromLength(16);
//   // static final encrypter = encrypt.Encrypter(encrypt.AES(key));

//   // static encryptAES(text) {
//   //   final encrypted = encrypter.encrypt(text, iv: iv);

//   //   print(encrypted.bytes);
//   //   print(encrypted.base16);
//   //   print(encrypted.base64);
//   //   return encrypted;
//   // }

//   // static decryptAES(text) {
//   //   final decrypted = encrypter.decrypt(text, iv: iv);
//   //   print(decrypted);
//   //   return decrypted;
//   // }

//   // For Fernet Encryption/Decryption
//   // static final keyFernet =
//   //     encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
//   // // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
//   // static final fernet = encrypt.Fernet(keyFernet);
//   // static final encrypterFernet = encrypt.Encrypter(fernet);

//   // static encryptFernet(text) {
//   //   final encrypted = encrypterFernet.encrypt(text);

//   //   print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
//   //   return encrypted;
//   // }

//   // static decryptFernet(text) {
//   //   return encrypterFernet.decrypt(text);
//   // }

//   // // For Salsa20 Encryption/Decryption
//   // static final keySalsa20 = encrypt.Key.fromLength(32);
//   // static final ivSalsa20 = encrypt.IV.fromLength(8);
//   // static final encrypteSalsa20 = encrypt.Encrypter(encrypt.Salsa20(keySalsa20));

//   // static encryptSalsa20(text) {
//   //   final encrypted = encrypteSalsa20.encrypt(text, iv: ivSalsa20);
//   //   // print(encrypted.bytes);
//   //   // print(encrypted.base16);
//   //   // print(encrypted.base64);
//   //   return encrypted;
//   // }

//   // static decryptSalsa20(text) {
//   //   return encrypteSalsa20.decrypt(text, iv: ivSalsa20);
//   // }
// }
