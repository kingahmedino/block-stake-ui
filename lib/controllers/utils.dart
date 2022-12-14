import 'package:intl/intl.dart';
import 'package:web3dart/web3dart.dart';

String getValueFromWeiToEther(dynamic value) {
  return EtherAmount.fromUnitAndValue(EtherUnit.wei, value)
      .getInEther
      .toString();
}

String getValueFromWeiToHumanReadable(dynamic value) {
  String ret =
      EtherAmount.fromUnitAndValue(EtherUnit.wei, value).getInEther.toString();
  return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
      .format(double.parse(ret));
}

String getValueInHumanReadable(String value) {
  return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
      .format(double.parse(value));
}
