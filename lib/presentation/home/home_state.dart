import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(false) bool isGoogleSheetLoading,
    @Default(true) bool isLoading,
    @Default([]) List<BookIntro> bookIntroList,
    BookIntro? curBookInfo,
    @Default([]) List<BookData> curBookData,
    @Default('') String imageUrl,
    @Default([]) List<Map<String,List<BookData>>> totalBookData,
  }) = _HomeState;
  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}