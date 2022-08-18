import 'package:intl/intl.dart';

String currencyFormat(int price) {
  var format = NumberFormat('###,###,### 원');
  return format.format(price);
}