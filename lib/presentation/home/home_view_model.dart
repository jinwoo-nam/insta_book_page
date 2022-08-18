import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/use_case/sheet_use_case.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final SheetUseCase sheetUseCase;

  HomeViewModel({
    required this.sheetUseCase,
  }) {
    initSheet();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

  Future<void> initSheet() async {
    await sheetUseCase.init();
    loadIntroData();
  }

  Future<void> loadIntroData() async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final res = await sheetUseCase.getIntroAll();

    final bookData = await loadPageData(res[0].issue);

    _state = state.copyWith(
      bookIntroList: res,
      isLoading: false,
      curBookInfo: res[0],
      curBookData: bookData,
      imageUrl: 'img/img11.jpeg',
    );

    notifyListeners();
  }

  void pageChange(int index) async {
    _state = state.copyWith(
      isLoading: true,
      imageUrl: '',
    );
    notifyListeners();

    final bookData = await loadPageData(
        state.bookIntroList[state.bookIntroList.length - index].issue);

    _state = state.copyWith(
      curBookInfo: state.bookIntroList[state.bookIntroList.length - index],
      curBookData: bookData,
      isLoading: false,
      imageUrl: getMainImage(index),
    );
    notifyListeners();
  }

  Future<List<BookData>> loadPageData(String page) async {
    await sheetUseCase.initPage(page);
    final res = await sheetUseCase.getBookData();
    return res;
  }

  String getMainImage(int index) {
    switch (index) {
      case 11:
        return 'img/img11.jpeg';
      case 10:
        return 'img/img10.jpeg';
      case 9:
        return 'img/img9.jpeg';
      case 8:
        return 'img/img8.jpeg';
      case 7:
        return 'img/img7.jpeg';
      case 6:
        return 'img/img7.jpeg';
      case 5:
        return 'img/img7.jpeg';
      case 4:
        return 'img/img7.jpeg';
      case 3:
        return 'img/img3.jpeg';
      case 2:
        return 'img/img3.jpeg';
      case 1:
        return 'img/img3.jpeg';
      default:
        return '';
    }
  }
}
