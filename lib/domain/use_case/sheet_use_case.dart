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

  Future<List<BookIntro>> getBookIntroListFromGoogleSheet() async {
    await init();
    final res = await getIntroAll();

    return res;
  }

  Future<List<Map<String, List<BookData>>>> totalBookDataLoadFromGoogleSheet(
      List<String> issues) async {
    List<Map<String, List<BookData>>> totalBookData = [];

    print('google sheet에서 issue 페이지의 데이터 읽어오기');
    for (final issue in issues) {
      //issue page 초기화
      await initPage(issue);
      //issue page에 있는 데이터 가져옴
      final res = await getBookData();
      //totalBookData에 데이터 저장
      totalBookData.add({issue: res});
    }

    return totalBookData;
  }

}
