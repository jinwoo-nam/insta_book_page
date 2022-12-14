import 'package:flutter_google_sheet_test/data/data_source/firestore_data_source.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/repository/firestore_repository.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  final dataSource = FirestoreDataSource();

  @override
  Future<List<Map<String, List<BookData>>>> getFirestoreBookDataList() async {
    return await dataSource.getFirestoreBookDataList();
  }

  @override
  Future<List<BookData>> getFirestoreBookData(String issue) async {
    return await dataSource.getFirestoreBookData(issue);
  }

  @override
  Future<List<BookIntro>> getFirestoreBookIntro() async {
    return await dataSource.getFirestoreBookIntro();
  }

  @override
  Future<DateTime?> getFirestoreLastSaveDate() async {
    return await dataSource.getFirestoreLastSaveDate();
  }

  @override
  Future<void> saveFirestoreBookDataList(
      String issue, List<Map<String, dynamic>> bookData) async {
    await dataSource.saveFirestoreBookDataList(issue, bookData);
  }

  @override
  Future<void> saveFirestoreBookIntro(
      String docName, BookIntro bookIntro) async {
    await dataSource.saveFirestoreBookIntro(docName, bookIntro);
  }

  @override
  Future<void> saveFirestoreLastSaveDate() async {
    await dataSource.saveFirestoreLastSaveDate();
  }
}
