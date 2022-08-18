import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';

abstract class SheetRepository {
  Future<void> init();
  Future<void> initPage(String page);
  Future<List<BookIntro>> getAll();
  Future<List<BookData>> getBookData();
}