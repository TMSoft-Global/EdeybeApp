import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/otp/otp.dart';
import 'package:edeybe/services/payment_operations.dart';
import 'package:edeybe/services/simpleWeb.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

class PaymentMethodController extends GetxController {
  var cards = <PaymentCard>[].obs;
  var cardNo = "".obs;
  final payementServer = PayementOperation();

  @override
  void onInit() {
    super.onInit();
    // Future.delayed(Duration(seconds: 1), () {
    payementServer.getAllSavedMethods((response) {
      cards.value = response;
      update();
    }, (error) {});
    // });
  }

  addPaymentMethod(PaymentCard card, {String otp}) {
    var alreadyAdded = cards.firstWhere(
      (element) => element.number == card.number,
      orElse: () => PaymentCard(),
    );
    if (alreadyAdded.number == null) {
      var data = card.toMoMoMap();
      if (otp != null) data.putIfAbsent('otp', () => otp);
      payementServer.saveMethod(data, (response) {
        if (otp != null) Get.back();

        update();
      }, (error) {});
    } else {
      Get.dialog(CustomDialog(
        title: S.current.addCard,
        content: S.current.cardExist,
      ));
    }
  }

  Future<String> encryptData(String data) async {
    final publicPem = await rootBundle.loadString('assets/public.pem');
    final privPem = await rootBundle.loadString('assets/private.pem');
    final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
    final privtKey = RSAKeyParser().parse(privPem) as RSAPrivateKey;

    final encrypter =
        Encrypter(RSA(publicKey: publicKey, privateKey: privtKey));
    final encrypted = encrypter.encrypt(data);
    // final decrypted = encrypter.decrypt(encrypted);

    return encrypted.base64;
  }

  verify(PaymentCard card, Map<String, dynamic> data) {
    print(data);
    if (card.paytype == 1) {
      payementServer.verifyCard(data, (error) {}, (val) {
        if (val != null) {
          print(val);
          Get.to(SimpleWebview());
        }
      });
    } else {
      payementServer.sendVerification(card.number, () {
        Get.to(
          Otp(
              data: card.number,
              onVerify: (String otp) => addPaymentMethod(card, otp: otp),
              onResend: (Function callBack) => payementServer.sendVerification(
                  card.number, () => callBack(), (error) {})),
        ).whenComplete(() {
          cards.add(card);
          update();
        });
      }, (error) {
        Get.dialog(Text(error.error));
      });
    }
  }

  eidtPaymentMethod(PaymentCard card) {
    int cardInList =
        cards.indexWhere((element) => element.number == card.number);
    if (cardInList != -1) {
      List<PaymentCard> cardCopy = List.from(cards);
      cardCopy[cardInList] = card;
      cards.value = cardCopy;
    }

    update();
  }

  removePaymentMethod(PaymentCard card) {
    if (cards != null) {
      payementServer.deleteMethod(card.id, (response) {
        if (response != null) {
          Get.dialog(CustomDialog(
            title: S.current.addCard,
            content: 'Card deleted successfully',
          ));
          print(response);
        }
        cards.removeWhere((element) {
          return element.number == card.number;
        });
      }, (error) {});
    } else {
      Get.dialog(CustomDialog(
        title: S.current.addCard,
        content: 'No Card Found',
      ));
    }

    update();
  }
}
