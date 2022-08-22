import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const String imagePre = 'https://bookthumb-phinf.pstatic.net/cover/';

String currencyFormat(int price) {
  var format = NumberFormat('###,###,### 원');
  return format.format(price);
}


void launchURL(String query) async {
  Uri uri = Uri.parse(query);
  if (!await launchUrl(uri)) throw 'Could not launch $query';
}
