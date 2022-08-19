import 'package:intl/intl.dart';

const String imagePre = 'https://bookthumb-phinf.pstatic.net/cover/';

String currencyFormat(int price) {
  var format = NumberFormat('###,###,### 원');
  return format.format(price);
}