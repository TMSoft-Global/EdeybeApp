import 'package:edeybe/encryption/encryptData.dart';
import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/otp/otp.dart';
import 'package:edeybe/services/payment_operations.dart';
import 'package:edeybe/services/simpleWeb.dart';
import 'package:edeybe/utils/card_enum.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends GetxController {
  var cards = <PaymentCard>[].obs;
  var cardNo = "", cvv, expMonth, expYear;
  final payementServer = PayementOperation();

  @override
  void onInit() {
    super.onInit();
    getAllPayment();
  }

  getAllPayment() {
    payementServer.getAllSavedMethods((response) {
      cards.value = response;
      update();
    }, (error) {});
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

  verify(PaymentCard card) async {
    if (card.paytype == 1) {
      await encryptData(card.number).then((value) => cardNo = value);
      await encryptData(card.cvv.toString()).then((value) => cvv = value);
      await encryptData(card.month.isLowerThan(10)
              ? "0${card.month.toString()}"
              : card.month.toString())
          .then((value) => expMonth = value);
      await encryptData(card.year.toString()).then((value) => expYear = value);
      Map<String, dynamic> data = {
        "pan": cardNo,
        "cvv": cvv,
        "exp_month": expMonth,
        "exp_year": expYear,
        "accountName": card.cardHolder,
        "cardType": card.type == CardType.Visa
            ? "VIS"
            : card.type == CardType.MasterCard
                ? "MAS"
                : "",
        "type": "card"
      };
      print("..........$data");
      print("..........${card.type}");
      payementServer.verifyCard(data, (error) {}, (val) {
        if (val != null) {
          print(val);
          if (val.containsKey('success')) {
            Get.to(SimpleWebview(
              url: val['success']['cardVerifyLink'],
            ));
          } else {
            print(val['error']);
            //    cards.add(card);
            // update();
          }
        } else {
          Get.dialog(Text("error"));
        }
      });
    } else {
      payementServer.sendVerification(card.number, () {
        // if (val.containsKey('success')) {
          Get.to(
            Otp(
                data: card.number,
                onVerify: (String otp) => addPaymentMethod(card, otp: otp),
                onResend: (Function callBack) =>
                    payementServer.sendVerification(card.number, () {
                      cards.add(card);
                      update();
                      getAllPayment();
                    }, (error) {})),
          ).whenComplete(() {
            cards.add(card);
            update();
            getAllPayment();
          });
        // }
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
          if (response.containsKey("success")) {
            Get.dialog(CustomDialog(
              title: S.current.addCard,
              content: 'Card deleted successfully',
            ));
            print(response);
            cards.removeWhere((element) {
              return element.id == card.id;
            });
          } else {
            Get.dialog(CustomDialog(
              title: S.current.addCard,
              content: response['error'],
            ));
          }
        }
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
