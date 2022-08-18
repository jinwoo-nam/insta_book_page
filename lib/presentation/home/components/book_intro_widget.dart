import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';

class BookIntroWidget extends StatelessWidget {
  final BookIntro? bookIntro;

  const BookIntroWidget({
    Key? key,
    required this.bookIntro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookIntro != null ? bookIntro!.inTitle : '',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            bookIntro != null ? bookIntro!.desc.replaceAll('[]', '') : '',
            style: const TextStyle(
              fontSize: 16,
              height: 1.9,
            ),
          ),
        ),
      ],
    );
  }
}
