String hasDecimal(String money) {
  if (money.toString().contains(".")) {
    return money.toString().substring(money.toString().length - 2);
  } else {
    return "00";
  }
}


String hasDecimalMain(String money) {
  if (money.toString().contains(".")) {
    return money.toString().substring(0, money.toString().length - 3);
  } else {
   return money;
  }
}
