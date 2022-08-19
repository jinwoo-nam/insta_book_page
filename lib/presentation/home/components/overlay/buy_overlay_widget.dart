import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/presentation/home/components/overlay/buy_overlay_loader.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_google_sheet_test/util/util.dart';

class BuyOverlayWidget extends StatelessWidget {
  const BuyOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BuyOverlayLoader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          final bookData = BuyOverlayLoader.appLoader.bookData;
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              alignment: Alignment.center,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  width: 600,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: IconButton(
                            onPressed: () {
                              BuyOverlayLoader.appLoader.hideLoader();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Image.network(
                                bookData.img.contains('https')
                                    ? bookData.img
                                    : imagePre + bookData.img,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookData.booktitle,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        bookData.author,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        bookData.publisher,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        bookData.pubdate,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      currencyFormat(
                                          int.parse(bookData.sprice)),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      currencyFormat(
                                          int.parse(bookData.rprice)),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${bookData.salerate}%',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  bookData.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text(
                                    '인스타페이 앱으로 하단의 바코드를 스캔하세요.',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                BarcodeWidget(
                                  barcode: Barcode.isbn(),
                                  data: bookData.isbn,
                                  width: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
