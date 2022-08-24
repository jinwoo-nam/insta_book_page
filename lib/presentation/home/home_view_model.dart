import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/use_case/sheet_use_case.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final SheetUseCase sheetUseCase;

  HomeViewModel({
    required this.sheetUseCase,
  }) {
    loadData();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

  StreamSubscription<QuerySnapshot>? _bookDataSubscription;

  Future<void> loadData() async {
//     _bookDataSubscription = FirebaseFirestore.instance
//         .collection('temp3')
//         .doc('timestamp')
// //        .collection('sub')
// //        .orderBy('timestamp', descending: true)
//         .snapshots()
//         .listen((snapshot) {
//       List<BookData> temp = [];
//       print(snapshot.docs.length);
//       for (final document in snapshot.docs) {
//         temp.add(
//           BookData(
//             booktitle: document.data()['issue'] as String,
//             author: document.data()['mainTitle'] as String,
//           ),
//         );
//       }
//
//       print(temp);
//     });

    final docRef = FirebaseFirestore.instance.collection('bookIntro');
    final bookIntroRef = await docRef.get();

    final timestampSnapshot = await FirebaseFirestore.instance
        .collection('timestamp')
        .doc('timestamp')
        .get();
    final time = timestampSnapshot.data();
    Timestamp? temp = time?['timestamp'];
    final DateTime? lastSavedDate = temp?.toDate();

    List<BookIntro> bookIntro = [];
    List<BookData> bookData = [];

    bookIntro =
        bookIntroRef.docs.map((e) => BookIntro.fromJson(e.data())).toList();

    if (lastSavedDate == null ||
        DateTime.now().difference(lastSavedDate).inDays > 0) {
      print('엑셀에서 읽기');
      await initAndLoadSheet(bookIntro: bookIntro, bookData: bookData);
    }
  }

  void disposeData() {
    _bookDataSubscription?.cancel();
  }

  Future<void> initAndLoadSheet({
    required List<BookIntro> bookIntro,
    required List<BookData> bookData,
  }) async {
    await sheetUseCase.init();
    await loadIntroDataFromGoogleSheet(
        bookIntro: bookIntro, bookData: bookData);
  }

  Future<void> loadIntroDataFromGoogleSheet({
    required List<BookIntro> bookIntro,
    required List<BookData> bookData,
  }) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final res = await sheetUseCase.getIntroAll();
    List<String> issues = [];
    res.forEach((element) {
      issues.add(element.issue);
    });

    bookIntro.forEach((element) {
      //print(element.issue);
    });

    print('res length ${res.length}');
    await totalBookDataLoad(issues);
    if (res.length != bookIntro.length) {
      for (int i = 0; i < res.length; i++) {
        FirebaseFirestore.instance
            .collection('bookIntro')
            .doc('${i + 1}'.padLeft(3, '0'))
            .set(res[i].toJson());
      }
      FirebaseFirestore.instance
          .collection('timestamp')
          .doc('timestamp')
          .set(<String, dynamic>{
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    //print(res);
    //
    // final bookData = await loadPageData(res[0].issue);
    //
    // _state = state.copyWith(
    //   bookIntroList: res,
    //   isLoading: false,
    //   curBookInfo: res[0],
    //   curBookData: bookData,
    //   imageUrl: 'img/img11.jpeg',
    // );

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

  Future<void> totalBookDataLoad(List<String> issues) async {
    List<Map<String, List<BookData>>> totalBookData = [];
    for (final issue in issues) {
      await sheetUseCase.initPage(issue);
      final res = await sheetUseCase.getBookData();
      totalBookData.add({issue: res});
    }
    print(totalBookData[0].keys.toList().first);

    for (final bookIssue in totalBookData) {
      String issue = bookIssue.keys.toList().first;
      List<BookData> bookDataList = bookIssue[issue] as List<BookData>;

      //print();

      // FirebaseFirestore.instance
      //     .collection('bookData')
      //     .doc(issue)
      //     .set({'data':bookDataList});

      List<Map<String,dynamic>> temp = [];
      for (final bookData in bookDataList) {
        temp.add(bookData.toJson());
      }
      FirebaseFirestore.instance
          .collection('bookData')
          .doc(issue)
          .set({'data':temp});
    }
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
