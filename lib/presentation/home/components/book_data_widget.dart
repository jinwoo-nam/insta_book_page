import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/presentation/home/components/overlay/buy_overlay_loader.dart';
import 'package:flutter_google_sheet_test/util/util.dart';

class BookDataWidget extends StatelessWidget {
  final BookData data;

  const BookDataWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.post_title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              const Icon(
                Icons.account_circle,
                size: 23,
              ),
              Text(
                '${data.post_author} 에디터',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              data.img.contains('https') ? data.img : imagePre + data.img,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: data.booktitle,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: '  ',
                              ),
                              TextSpan(
                                text: data.author,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      data.publisher,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        currencyFormat(int.parse(data.sprice)),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        currencyFormat(int.parse(data.rprice)),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          BuyOverlayLoader.appLoader.showLoader(data);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.brown),
                        ),
                        child: const Text(
                          '구매하기',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            data.post_body.replaceAll('[]', '\n'),
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 40,
          ),
          child: Divider(
            height: 1.5,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
