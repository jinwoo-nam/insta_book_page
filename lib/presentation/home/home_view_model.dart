import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:flutter_google_sheet_test/domain/use_case/firestore_use_case.dart';
import 'package:flutter_google_sheet_test/domain/use_case/sheet_use_case.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class HomeViewModel with ChangeNotifier {
  final SheetUseCase sheetUseCase;
  final FirestoreUseCase firestoreUseCase;

  HomeViewModel({
    required this.sheetUseCase,
    required this.firestoreUseCase,
  }) {
    loadData();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

  Future<void> loadData() async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    //Firestore data Load
    DateTime? lastSavedDate = await firestoreUseCase.getFirestoreLastSaveDate();
    List<BookIntro> bookIntroFromFirestore =
        await firestoreUseCase.getFirestoreBookIntro();

    final List<String> firestoreIssues = [];
    if (bookIntroFromFirestore.isNotEmpty) {
      for (final data in bookIntroFromFirestore) {
        firestoreIssues.add(data.issue);
      }
    }

    if (lastSavedDate == null || DateTime.now().day != lastSavedDate.day) {
      _state = state.copyWith(
        isGoogleSheetLoading: true,
      );
      notifyListeners();

      List<String> googleSheetIssues = [];
      //google sheet에서 book intro 읽기
      List<BookIntro> bookIntroFromGoogleSheet =
          await sheetUseCase.getBookIntroListFromGoogleSheet();

      for (final bookIntro in bookIntroFromGoogleSheet) {
        googleSheetIssues.add(bookIntro.issue);
      }
      firestoreIssues.sort();
      googleSheetIssues.sort();

      //firestore에 저장된 issue와 google sheet의 issue가 다르면
      if (const DeepCollectionEquality()
              .equals(firestoreIssues, googleSheetIssues) ==
          false) {
        //google sheet의 bookData 읽어서 firstore에 저장

        //1.google sheet의 issue 중 firestore에 저장되어있는 issue는 빼기(중복 제거)
        for (final firestoreIssue in firestoreIssues) {
          googleSheetIssues.remove(firestoreIssue);
        }
        //2.google sheet에서 book data load(firestore에 없는것만)
        if (googleSheetIssues.isNotEmpty) {
          print('load bookd data from google sheet');
          final List<Map<String, List<BookData>>> addedBookDataList =
              await sheetUseCase
                  .totalBookDataLoadFromGoogleSheet(googleSheetIssues);

          print('save addedBookData');
          for (final bookData in addedBookDataList) {
            String issue = bookData.keys.toList().first;
            List<BookData> bookDataList = bookData[issue] as List<BookData>;

            List<Map<String, dynamic>> temp = [];
            for (final bookData in bookDataList) {
              temp.add(bookData.toJson());
            }
            firestoreUseCase.saveFirestoreBookDataList(issue, temp);
          }

          //5.google sheet에서 읽은 book intro를 firestore에 저장
          if (bookIntroFromGoogleSheet.length !=
              bookIntroFromFirestore.length) {
            for (int i = 0; i < bookIntroFromGoogleSheet.length; i++) {
              firestoreUseCase.saveFirestoreBookIntro(
                  '${i + 1}'.padLeft(3, '0'), bookIntroFromGoogleSheet[i]);
            }
          }
        }

        //google sheet에서 읽어온 data를 cur data에 넣어준다.
        bookIntroFromFirestore = await firestoreUseCase.getFirestoreBookIntro();
        List<BookData> bookDataFromFirebase =
            await firestoreUseCase
                .getFirestoreBookData(bookIntroFromFirestore[0].issue);

        List<BookData> bookData = bookDataFromFirebase;

        _state = state.copyWith(
          bookIntroList: bookIntroFromGoogleSheet,
          totalBookData: [],
          curBookInfo: bookIntroFromFirestore[0],
          curBookData: bookData,
          isLoading: false,
          imageUrl: 'img/img11.jpeg',
        );
      } else {
        //firestore에 저장된 issue와 google sheet의 issue가 같을때 (google sheet에서 data 안읽어도 됨)
        //firestore에서 읽어온 data를 cur data에 넣어준다.
        List<BookData> bookDataFromFirebase =
            await firestoreUseCase
                .getFirestoreBookData(bookIntroFromFirestore[0].issue);
        List<BookData> bookData = bookDataFromFirebase;
        _state = state.copyWith(
          bookIntroList: bookIntroFromFirestore,
          totalBookData: [],
          curBookInfo: bookIntroFromFirestore[0],
          curBookData: bookData,
          isLoading: false,
          imageUrl: 'img/img11.jpeg',
        );
      }

      //firestore timestamp update
      firestoreUseCase.saveFirestoreLastSaveDate();
    } else {
      List<BookData> bookDataFromFirebase = await firestoreUseCase
          .getFirestoreBookData(bookIntroFromFirestore[0].issue);
      List<BookData> bookData = bookDataFromFirebase;

      _state = state.copyWith(
        isLoading: false,
        bookIntroList: bookIntroFromFirestore,
        isGoogleSheetLoading: false,
        totalBookData: [],
        curBookInfo:
            bookIntroFromFirestore.isEmpty ? null : bookIntroFromFirestore[0],
        curBookData: bookData,
        imageUrl: 'img/img11.jpeg',
      );
    }

    notifyListeners();
  }

  void pageChange(int index) async {
    List<BookData> bookDataFromFirebase =
        await firestoreUseCase.getFirestoreBookData(
            state.bookIntroList[state.bookIntroList.length - index].issue);
    List<BookData> bookData = bookDataFromFirebase;

    _state = state.copyWith(
      curBookInfo: state.bookIntroList[state.bookIntroList.length - index],
      curBookData: bookData,
      imageUrl: getMainImage(index),
    );
    notifyListeners();
  }

  String getMainImage(int index) {
    if (index > 11) {
      index = 11;
    }
    return 'img/img$index.jpeg';
  }
}
