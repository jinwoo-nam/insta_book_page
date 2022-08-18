import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/repository/sheet_repository.dart';

class SheetUseCase {
  final SheetRepository repository;

  SheetUseCase(this.repository);

  Future<void> init() async {
    return await repository.init();
  }

  Future<void> initPage(String page) async {
    return await repository.initPage(page);
  }

  Future<List<BookIntro>> getIntroAll() async {
    return await repository.getAll();
  }

  Future<List<BookData>> getBookData() async {
    return await repository.getBookData();
  }
}
