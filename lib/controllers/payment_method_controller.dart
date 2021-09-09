import 'package:edeybe/index.dart';
import 'package:edeybe/models/card.dart';
import 'package:edeybe/screens/otp/otp.dart';
import 'package:edeybe/services/payment_operations.dart';
import 'package:edeybe/widgets/custom_dialog.dart';

class PaymentMethodController extends GetxController {
  var cards = <PaymentCard>[].obs;
  final payementServer = PayementOperation();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      payementServer.getAllSavedMethods((response) {
        cards.value = response;
        update();
      }, (error) {});
    });
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
        cards.add(card);
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
    payementServer.sendVerification(
        card.number,
        () => Get.to(Otp(
            data: card.number,
            onVerify: (String otp) => addPaymentMethod(card, otp: otp),
            onResend: (Function callBack) => payementServer.sendVerification(
                card.number, () => callBack(), (error) {}))),
        (error) {});
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
    cards.removeWhere((element) => element.number == card.number);
    update();
  }
}
