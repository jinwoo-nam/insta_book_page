import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';

class FirestoreDataSource {
  Future<DateTime?> getFirestoreLastSaveDate() async {
    final timestampSnapshot = await FirebaseFirestore.instance
        .collection('timestamp')
        .doc('timestamp')
        .get();
    final DateTime? lastSavedDate =
        timestampSnapshot.data()?['timestamp']?.toDate();
    return lastSavedDate;
  }

  Future<void> saveFirestoreLastSaveDate() async {
    FirebaseFirestore.instance
        .collection('timestamp')
        .doc('timestamp')
        .set(<String, dynamic>{
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, List<BookData>>>> getFirestoreBookData() async {
    List<Map<String, List<BookData>>> totalBookData = [];
    final bookDocRef = FirebaseFirestore.instance.collection('bookData');
    final bookDataRef = await bookDocRef.get();
    for (final doc in bookDataRef.docs) {
      Iterable data = doc.data()['data'];
      List<BookData> bookData = data.map((e) => BookData.fromJson(e)).toList();
      totalBookData.add({doc.id: bookData});
    }
    return totalBookData;
  }

  Future<void> saveFirestoreBookData(
      String issue, List<Map<String, dynamic>> bookData) async {
    FirebaseFirestore.instance
        .collection('bookData')
        .doc(issue)
        .set({'data': bookData});
  }

  Future<List<BookIntro>> getFirestoreBookIntro() async {
    final bookIntroRef =
        await FirebaseFirestore.instance.collection('bookIntro').get();
    List<BookIntro> bookIntro = [];
    bookIntro =
        bookIntroRef.docs.map((e) => BookIntro.fromJson(e.data())).toList();
    return bookIntro;
  }

  Future<void> saveFirestoreBookIntro(
      String docName, BookIntro bookIntro) async {
    FirebaseFirestore.instance
        .collection('bookIntro')
        .doc(docName)
        .set(bookIntro.toJson());
  }
}
