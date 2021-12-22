// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:edeybe/utils/card_utils.dart';
import 'package:edeybe/utils/card_enum.dart';

class PaymentCard {
  CardType type;
  String number;
  String recipientNumber;
  String cardHolder;
  String paymode;
  int paytype;
  int month;
  int year;
  int cvv;
  String id;

  PaymentCard(
      {this.type,
      this.id,
      this.number,
      this.recipientNumber,
      this.cardHolder,
      this.month,
      this.year,
      this.cvv,
      this.paytype,
      this.paymode});
  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json['type'] == 'momo') {
      var type = CardType.values.firstWhere(
          (element) =>
              element.toString().split(".").last == json['mobileNetwork'],
          orElse: () => null);
      return PaymentCard(
          id: json['_id'],
          type: type,
          cardHolder: json['accountName'],
          number: json['mobileNumber'],
          paymode: json['mobileNetwork'],
          paytype: 0);
    } else if (json['type'] == 'card') {
      var type;
      if (json['cardType'] == 'VIS')
        type = CardType.Visa;
      else
        type = CardType.MasterCard;

      return PaymentCard(
          id: json['_id'],
          type: type,
          cardHolder: json['accountName'],
          number: json['masked'],
          paytype: 1);
    }else{
      return PaymentCard();
    }
  }
  Map<String, dynamic> toMap() {
    var strYear = year.toString();
    var strMonth = month.toString();
    if (strMonth.length == 1) strMonth = "0$strMonth";
    if (strYear.length == 1) strMonth = "0$strYear";
    return {
      "paymode": CardUtils.cardAbreviaton(type),
      "cardHolder": cardHolder,
      "type": type,
      "number": number,
      "recipientNumber": recipientNumber,
      "paytype": paytype,
      "expiry_date": "$strMonth/$strYear",
    };
  }

  Map<String, dynamic> toMoMoMap() {
    return {
      "mobileNetwork": CardUtils.cardAbreviaton(type),
      "accountName": cardHolder,
      "mobileNumber": number,
      "recipientNumber": recipientNumber,
      "type": 'momo',
    };
  }

  Map<String, dynamic> toMapDb() {
    var strYear = year.toString();
    var strMonth = month.toString();
    if (strMonth.length == 1) strMonth = "0$strMonth";
    if (strYear.length == 1) strMonth = "0$strYear";
    return {
      "paymode": CardUtils.cardAbreviaton(type),
      "cardHolder": cardHolder,
      "type": type.toString(),
      "number": number,
      "recipientNumber": recipientNumber,
      "paytype": paytype,
      "expiry_date": "$strMonth/$strYear",
    };
  }
}
