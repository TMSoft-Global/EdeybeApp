import 'package:edeybe/utils/card_enum.dart';
import 'package:edeybe/utils/strings.dart';
import 'package:flutter/material.dart';

class CardUtils {
  static Widget getCardIcon(CardType cardType) {
    String img = "";
    Icon icon;
    switch (cardType) {
      case CardType.MasterCard:
        img = 'mastercard.png';
        break;
      case CardType.Visa:
        img = 'visa.png';
        break;
      case CardType.ATL:
        img = 'ATL.png';
        break;
      case CardType.MTN:
        img = 'MTN.png';
        break;
      case CardType.VDF:
        img = 'VDF.png';
        break;
      // case CardType.Verve:
      //   img = 'verve.png';
      //   break;
      // case CardType.AmericanExpress:
      //   img = 'american_express.png';
      //   break;
      // case CardType.Discover:
      //   img = 'discover.png';
      //   break;
      // case CardType.DinersClub:
      //   img = 'dinners_club.png';
      //   break;
      // case CardType.Jcb:
      //   img = 'jcb.png';
      //   break;
      // case CardType.Others:
      //   icon = new Icon(
      //     Icons.credit_card,
      //     size: 40.0,
      //     color: Colors.grey[600],
      //   );
      //   break;
      case CardType.Invalid:
        icon = new Icon(
          Icons.warning,
          size: 30.0,
          color: Colors.grey[600],
        );
        break;
    }

    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        'assets/images/$img',
        width: 20.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static Widget getMomoIcon(MomoType cardType) {
    String img = "";
    Icon icon;
    switch (cardType) {
      case MomoType.ATL:
        img = 'ATL.png';
        break;
      case MomoType.MTN:
        img = 'MTN.png';
        break;
      case MomoType.VDF:
        img = 'VDF.png';
        break;
      // case CardType.Verve:
      //   img = 'verve.png';
      //   break;
      // case CardType.AmericanExpress:
      //   img = 'american_express.png';
      //   break;
      // case CardType.Discover:
      //   img = 'discover.png';
      //   break;
      // case CardType.DinersClub:
      //   img = 'dinners_club.png';
      //   break;
      // case CardType.Jcb:
      //   img = 'jcb.png';
      //   break;
      // case CardType.Others:
      //   icon = new Icon(
      //     Icons.credit_card,
      //     size: 40.0,
      //     color: Colors.grey[600],
      //   );
      //   break;
      case MomoType.Invalid:
        icon = new Icon(
          Icons.warning,
          size: 40.0,
          color: Colors.grey[600],
        );
        break;
    }

    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        'assets/images/$img',
        width: 30.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static String validateCardNumWithLuhnAlgorithm(String input) {
    if (input.isEmpty) {
      return Strings.fieldReq;
    }
    if (input.contains("******")) {
      return null;
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      // No need to even proceed with the validation if it's less than 8 characters
      return Strings.numberIsInvalid;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return Strings.numberIsInvalid;
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.MasterCard;
    } else if (input.startsWith(new RegExp(r'4[0-9]{12}(?:[0-9]{3})'))) {
      cardType = CardType.Visa;
    }
    // else if (input
    //     .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
    //   cardType = CardType.Verve;
    // }
    // else if (input.length <= 8) {
    //   cardType = CardType.Others;
    // }
    else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static CardType getMomoTypeFrmNumber(String input) {
    CardType cardType;
    if (input == "ATL") {
      cardType = CardType.ATL;
    } else if (input == "MTN") {
      cardType = CardType.MTN;
    } else if (input == "VDF") {
      cardType = CardType.VDF;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static String validateDate(String value) {
    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return Strings.mondIsInvalid;
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return Strings.yearIsInvalid;
    }

    if (!hasDateExpired(month, year)) {
      return Strings.cardHasExpired;
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static String validateCVV(String value) {
    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    if (value.length < 3 || value.length > 4) {
      return Strings.cvvIsInvalid;
    }
    return null;
  }

  static String validateName(String value) {
    final nameRegex = new RegExp(r'^[a-zA-Z].{2,}$');

    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    if (!nameRegex.hasMatch(value)) {
      return Strings.nameIsInvalid;
    }
    return null;
  }

  static String validateVoucherCode(String value) {
    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    if (value.length < 3 || value.length > 4) {
      return Strings.voucherIsInvalid;
    }
    return null;
  }

  static String fuseEncryptAlgorithm(String value) {
    var timenow = DateTime.now();
    var timestamp = timenow.millisecondsSinceEpoch;
    var buffer = new StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != value.length) {
        buffer.write(timestamp);
      }
    }

    return buffer.toString();
  }

  static String fuseDecryptAlgorithm(String value, String key) {
    return value.replaceAll(RegExp(key), '');
  }

  static String cardAbreviaton(CardType type) {
    String abv;
    switch (type) {
      case CardType.MasterCard:
        abv = 'MAS';
        break;
      case CardType.Visa:
        abv = 'VIS';
        break;
      case CardType.MTN:
        abv = 'MTN';
        break;
      case CardType.ATL:
        abv = 'ATL';
        break;
      case CardType.VDF:
        abv = 'VDF';
        break;
      case CardType.TGO:
        abv = 'TGO';
        break;
      // case CardType.Verve:
      //   abv = 'verve.png';
      //   break;
      // case CardType.AmericanExpress:
      //   abv = 'american_express.png';
      //   break;
      // case CardType.Discover:
      //   abv = 'discover.png';
      //   break;
      // case CardType.DinersClub:
      //   abv = 'dinners_club.png';
      //   break;
      // case CardType.Jcb:
      //   abv = 'jcb.png';
      //   break;
      // case CardType.Others:

      //   break;
      case CardType.Invalid:
        break;
    }
    return abv;
  }

  static String cardTypeName(CardType type) {
    String abv;
    switch (type) {
      case CardType.MasterCard:
        abv = 'MASTER CARD';
        break;
      case CardType.Visa:
        abv = 'VISA';
        break;
      case CardType.MTN:
        abv = 'MTN';
        break;
      case CardType.ATL:
        abv = 'Airtel Tigo';
        break;
      case CardType.VDF:
        abv = 'Vodafone';
        break;
      // case CardType.Verve:
      //   abv = 'verve.png';
      //   break;
      // case CardType.AmericanExpress:
      //   abv = 'american_express.png';
      //   break;
      // case CardType.Discover:
      //   abv = 'discover.png';
      //   break;
      // case CardType.DinersClub:
      //   abv = 'dinners_club.png';
      //   break;
      // case CardType.Jcb:
      //   abv = 'jcb.png';
      //   break;
      // case CardType.Others:

      //   break;
      case CardType.Invalid:
        break;
    }
    return abv;
  }

  static String momoTypeName(MomoType type) {
    String abv;
    switch (type) {
      case MomoType.MTN:
        abv = 'MTN';
        break;
      case MomoType.ATL:
        abv = 'Airtel Tigo';
        break;
      case MomoType.VDF:
        abv = 'Vodafone';
        break;
      case MomoType.Invalid:
        break;
    }
    return abv;
  }

  static String maskCard(text) {
    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i < text.length - 4) {
        buffer.write('* '); // Add double spaces.
      } else {
        buffer.write(text[i]);
      }
    }

    return buffer.toString();
  }

  static validateMobileNumber(text) {
    final mobileNumberRegex = new RegExp(r'^([0]?:[25][0-9])?[0-9]{10}$');
    return mobileNumberRegex.hasMatch(text);
  }
}
