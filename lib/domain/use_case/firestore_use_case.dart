import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/repository/firestore_repository.dart';

class FirestoreUseCase {
  final FirestoreRepository repository;

  FirestoreUseCase(this.repository);

  Future<DateTime?> getFirestoreLastSaveDate() async {
    return await repository.getFirestoreLastSaveDate();
  }

  Future<void> saveFirestoreLastSaveDate() async {
    await repository.saveFirestoreLastSaveDate();
  }

  Future<List<Map<String, List<BookData>>>> getFirestoreBookData() async {
    return await repository.getFirestoreBookData();
  }

  Future<void> saveFirestoreBookData(
      String issue, List<Map<String, dynamic>> bookData) async {
    await repository.saveFirestoreBookData(issue, bookData);
  }

  Future<List<BookIntro>> getFirestoreBookIntro() async {
    return await repository.getFirestoreBookIntro();
  }

  Future<void> saveFirestoreBookIntro(
      String docName, BookIntro bookIntro) async {
    await repository.saveFirestoreBookIntro(docName, bookIntro);
  }
}
