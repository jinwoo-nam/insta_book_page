import 'package:flutter_google_sheet_test/data/data_source/book_sheets_api.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/repository/sheet_repository.dart';

class SheetRepositoryImpl implements SheetRepository {
  final sheetsApi = BookSheetsApi();

  @override
  Future<void> init() async {
    await sheetsApi.init();
  }

  @override
  Future<void> initPage(String page) async {
    await sheetsApi.initPage(page);
  }

  @override
  Future<List<BookIntro>> getAll() async {
    return await sheetsApi.getIntroAll();
  }

  @override
  Future<List<BookData>> getBookData() async {
    return await sheetsApi.getBookData();
  }
}
