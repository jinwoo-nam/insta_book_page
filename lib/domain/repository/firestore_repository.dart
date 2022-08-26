import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';

abstract class FirestoreRepository {
  Future<DateTime?> getFirestoreLastSaveDate();

  Future<void> saveFirestoreLastSaveDate();

  Future<List<Map<String, List<BookData>>>> getFirestoreBookData();

  Future<void> saveFirestoreBookData(
      String issue, List<Map<String, dynamic>> bookData);

  Future<List<BookIntro>> getFirestoreBookIntro();

  Future<void> saveFirestoreBookIntro(String docName, BookIntro bookIntro);
}
