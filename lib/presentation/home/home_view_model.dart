import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/use_case/sheet_use_case.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    //Firestore data Load
    DateTime? lastSavedDate = await getFirestoreLastSaveDate();
    List<BookIntro> bookIntro = await getFirestoreBookIntro();
    List<Map<String, List<BookData>>> totalBookData =
        await getFirestoreBookData();

    final List<String> firestoreIssues = [];
    for (final data in totalBookData) {
      firestoreIssues.add(data.keys.first);
    }

    if (lastSavedDate == null ||
        DateTime.now().difference(lastSavedDate).inDays > 0) {
      print('google sheet에서 읽기');
      List<String> googleSheetIssues = [];
      //google sheet에서 book intro 읽기
      List<BookIntro> bookIntroList = await getBookIntroListFromGoogleSheet();
      for (final bookIntro in bookIntroList) {
        googleSheetIssues.add(bookIntro.issue);
      }
      firestoreIssues.sort();
      googleSheetIssues.sort();

      if (const DeepCollectionEquality()
          .equals(firestoreIssues, googleSheetIssues)) {
        //google sheet의 bookData 읽을 필요없음

      } else {
        //google sheet의 bookData 읽어서 firstore에 저장

        //1.google sheet의 issue 중 firestore에 저장되어있는 issue는 빼기(중복 제거)
        for (final firestoreIssue in firestoreIssues) {
          googleSheetIssues.remove(firestoreIssue);
        }
        //2.google sheet에서 book data load(firestore에 없는것만)
        if (googleSheetIssues.isNotEmpty) {
          final List<Map<String, List<BookData>>> addedBookDataList = await totalBookDataLoadFromGoogleSheet(googleSheetIssues);

          //3.totalBookData와 새로 읽어온 BookData 합침
          totalBookData = List.from(totalBookData)..addAll(addedBookDataList);

          //4.totalBookData를 firestore에 저장

          //5.book intro를 firestore에 저장

          //6.curBookData를 잘 입력하면 됨.
        }
      }
    }
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

  Future<List<BookIntro>> getFirestoreBookIntro() async {
    final bookIntroRef =
        await FirebaseFirestore.instance.collection('bookIntro').get();
    List<BookIntro> bookIntro = [];
    bookIntro =
        bookIntroRef.docs.map((e) => BookIntro.fromJson(e.data())).toList();
    return bookIntro;
  }

  Future<DateTime?> getFirestoreLastSaveDate() async {
    final timestampSnapshot = await FirebaseFirestore.instance
        .collection('timestamp')
        .doc('timestamp')
        .get();
    final DateTime? lastSavedDate =
        timestampSnapshot.data()?['timestamp']?.toDate();
    return lastSavedDate;
  }

  void disposeData() {
    _bookDataSubscription?.cancel();
  }

  Future<List<BookIntro>> getBookIntroListFromGoogleSheet() async {
    // _state = state.copyWith(
    //   isLoading: true,
    // );
    // notifyListeners();
    await sheetUseCase.init();
    final res = await sheetUseCase.getIntroAll();

    return res;
    /*
    * List<String> issues = [];

    for (var element in res) {
      issues.add(element.issue);
    }

    for (var element in bookIntro) {
      //print(element.issue);
    }

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
    * */
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

  Future<List<Map<String, List<BookData>>>> totalBookDataLoadFromGoogleSheet(List<String> issues) async {
    List<Map<String, List<BookData>>> totalBookData = [];

    print('google sheet에서 issue 페이지의 데이터 읽어오기');
    for (final issue in issues) {
      //issue page 초기화
      await sheetUseCase.initPage(issue);
      //issue page에 있는 데이터 가져옴
      final res = await sheetUseCase.getBookData();
      //totalBookData에 데이터 저장
      totalBookData.add({issue: res});
    }

    return totalBookData;

    // print('google sheet에서 읽어온 데이터 firestore에 저장');
    // for (final bookIssue in totalBookData) {
    //   String issue = bookIssue.keys.toList().first;
    //   List<BookData> bookDataList = bookIssue[issue] as List<BookData>;
    //
    //   List<Map<String,dynamic>> temp = [];
    //   for (final bookData in bookDataList) {
    //     temp.add(bookData.toJson());
    //   }
    //   FirebaseFirestore.instance
    //       .collection('bookData')
    //       .doc(issue)
    //       .set({'data':temp});
    // }
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
