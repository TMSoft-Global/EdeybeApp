import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

// import 'package:crypton/crypton.dart';

// import 'encryption.dart';
// class Encryption {
//   static void decryptData(String data) {
//     String pubKey =
//         'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAO0oE4LPIW72BSn7pggDQABSFbR3d0aokYmepRfL9j+9xPNM6TiM7nK2ome/a6R3kZebwRUycLZJW+yYARHI80UCAwEAAQ==';
//     final rsaKeypair = RSAKeypair.fromRandom();
//     final message = data;

//     final privateKeyString = rsaKeypair.privateKey.toString();
//     final publicKeyString = pubKey;
//     final encrypted = rsaKeypair.publicKey.encrypt(message);
//     final decrypted = rsaKeypair.privateKey.decrypt(encrypted);

//     print('Your Private Key\n $privateKeyString\n---');
//     print('Your Public Key\n $publicKeyString\n---');
//     print('Encrypted Message\n $encrypted\n---');
//     print('Decrypted Message\n $decrypted\n---');

//     if (decrypted == message) {
//       print('The Message was successfully decrypted!');
//     } else {
//       print('Failed to decrypted the Message!');
//     }
//   }
// }

Future<String> encryptData(String data) async {
  final publicPem = await rootBundle.loadString('assets/public.pem');
  final privPem = await rootBundle.loadString('assets/private.pem');
  final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
  final privtKey = RSAKeyParser().parse(privPem) as RSAPrivateKey;

  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privtKey));
  final encrypted = encrypter.encrypt(data);
  // final decrypted = encrypter.decrypt(encrypted);

  // print(
  //     "===============$decrypted"); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  return encrypted
      .base64; // kO9EbgbrSwiq0EYz0aBdljHSC/rci2854Qa+nugbhKjidlezNplsEqOxR+pr1RtICZGAtv0YGevJBaRaHS17eHuj7GXo1CM3PR6pjGxrorcwR5Q7/bVEePESsimMbhHWF+AkDIX4v0CwKx9lgaTBgC8/yJKiLmQkyDCj64J3JSE=
}
