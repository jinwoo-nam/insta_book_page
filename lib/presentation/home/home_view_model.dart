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
    print('1. firestore data load');
    DateTime? lastSavedDate = await firestoreUseCase.getFirestoreLastSaveDate();
    List<BookIntro> bookIntroFromFirestore =
        await firestoreUseCase.getFirestoreBookIntro();
    List<Map<String, List<BookData>>> totalBookData =
        await firestoreUseCase.getFirestoreBookData();

    final List<String> firestoreIssues = [];
    if (totalBookData.isNotEmpty) {
      for (final data in totalBookData) {
        firestoreIssues.add(data.keys.first);
      }
    }

    if (lastSavedDate == null || DateTime.now().day != lastSavedDate.day) {
      _state = state.copyWith(
        isGoogleSheetLoading: true,
      );
      notifyListeners();

      print('2. google sheet data 읽기');
      List<String> googleSheetIssues = [];
      //google sheet에서 book intro 읽기
      List<BookIntro> bookIntroFromGoogleSheet =
          await sheetUseCase.getBookIntroListFromGoogleSheet();

      for (final bookIntro in bookIntroFromGoogleSheet) {
        googleSheetIssues.add(bookIntro.issue);
      }
      firestoreIssues.sort();
      googleSheetIssues.sort();

      print('3. 구글 sheet와 firestore data 비교');
      //firestore에 저장된 issue와 google sheet의 issue가 다르면
      if (const DeepCollectionEquality()
              .equals(firestoreIssues, googleSheetIssues) ==
          false) {
        print('4. 구글 sheet와 firestore data 다를 때');
        //google sheet의 bookData 읽어서 firstore에 저장

        //1.google sheet의 issue 중 firestore에 저장되어있는 issue는 빼기(중복 제거)
        for (final firestoreIssue in firestoreIssues) {
          googleSheetIssues.remove(firestoreIssue);
        }
        //2.google sheet에서 book data load(firestore에 없는것만)
        if (googleSheetIssues.isNotEmpty) {
          final List<Map<String, List<BookData>>> addedBookDataList =
              await sheetUseCase
                  .totalBookDataLoadFromGoogleSheet(googleSheetIssues);

          //3.totalBookData와 새로 읽어온 BookData 합침
          totalBookData = List.from(totalBookData)..addAll(addedBookDataList);

          //4.totalBookData를 firestore에 저장
          print('5. total book data firstore에 저장');
          for (final bookIssue in totalBookData) {
            String issue = bookIssue.keys.toList().first;
            List<BookData> bookDataList = bookIssue[issue] as List<BookData>;

            List<Map<String, dynamic>> temp = [];
            for (final bookData in bookDataList) {
              temp.add(bookData.toJson());
            }
            firestoreUseCase.saveFirestoreBookData(issue, temp);
          }

          //5.google sheet에서 읽은 book intro를 firestore에 저장
          print('6. google sheet에서 읽은 book intro를 firstore에 저장');
          if (bookIntroFromGoogleSheet.length !=
              bookIntroFromFirestore.length) {
            for (int i = 0; i < bookIntroFromGoogleSheet.length; i++) {
              firestoreUseCase.saveFirestoreBookIntro(
                  '${i + 1}'.padLeft(3, '0'), bookIntroFromGoogleSheet[i]);
            }
          }
        }

        print('google sheet에서 읽어온 data를 cur data에 넣어준다.');
        //google sheet에서 읽어온 data를 cur data에 넣어준다.
        totalBookData = await firestoreUseCase.getFirestoreBookData();
        bookIntroFromFirestore = await firestoreUseCase.getFirestoreBookIntro();

        List<BookData> bookData = [];
        for (final data in totalBookData) {
          if (data.keys.first == bookIntroFromFirestore[0].issue) {
            bookData = data.values.first;
            break;
          }
        }

        print('state 초기화');
        _state = state.copyWith(
          bookIntroList: bookIntroFromGoogleSheet,
          totalBookData: totalBookData,
          curBookInfo: bookIntroFromFirestore[0],
          curBookData: bookData,
          isLoading: false,
          imageUrl: 'img/img11.jpeg',
        );
      } else {
        //firestore에 저장된 issue와 google sheet의 issue가 같을때 (google sheet에서 data 안읽어도 됨)
        //firestore에서 읽어온 data를 cur data에 넣어준다.

        List<BookData> bookData = [];
        for (final data in totalBookData) {
          if (data.keys.first == bookIntroFromFirestore[0].issue) {
            bookData = data.values.first;
            break;
          }
        }
        _state = state.copyWith(
          bookIntroList: bookIntroFromFirestore,
          totalBookData: totalBookData,
          curBookInfo: bookIntroFromFirestore[0],
          curBookData: bookData,
          isLoading: false,
          imageUrl: 'img/img11.jpeg',
        );
      }

      //firestore timestamp update
      firestoreUseCase.saveFirestoreLastSaveDate();
    } else {
      List<BookData> bookData = [];
      for (final data in totalBookData) {
        if (data.keys.first == bookIntroFromFirestore[0].issue) {
          bookData = data.values.first;
          break;
        }
      }

      _state = state.copyWith(
        isLoading: false,
        bookIntroList: bookIntroFromFirestore,
        isGoogleSheetLoading: false,
        totalBookData: totalBookData,
        curBookInfo:
            bookIntroFromFirestore.isEmpty ? null : bookIntroFromFirestore[0],
        curBookData: bookData,
        imageUrl: 'img/img11.jpeg',
      );
    }

    notifyListeners();
  }

  void pageChange(int index) async {
    List<BookData> bookData = [];
    for (final data in state.totalBookData) {
      if (data.keys.first ==
          state.bookIntroList[state.bookIntroList.length - index].issue) {
        bookData = data.values.first;
        break;
      }
    }

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
