import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';

class BuyOverlayLoader {
  static final BuyOverlayLoader appLoader = BuyOverlayLoader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderTextNotifier = ValueNotifier('error message');
  late BookData bookData;

  void showLoader(BookData data) {
    loaderShowingNotifier.value = true;
    bookData = data.copyWith();
  }

  void hideLoader() {
    loaderShowingNotifier.value = false;
  }
}
