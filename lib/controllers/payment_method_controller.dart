import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/otp/otp.dart';
import 'package:edeybe/services/payment_operations.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:edeybe/widgets/custom_web_view.dart';

class PaymentMethodController extends GetxController {
  var cards = <PaymentCard>[].obs;
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

  verify(PaymentCard card) {
    print(card.paytype.toString());
    if (card.paytype == 1) {
      payementServer.verifyCard({"": ""}, (error) {}, (val) {
        if (val != null) {
              Get.to(CustomWebView(
            title: "Term and Conditions",
            url: val['url'],
            onLoadFinish: (onREsponse){
              print(onREsponse);
            },
          ));
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
      }, (error) {});
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
