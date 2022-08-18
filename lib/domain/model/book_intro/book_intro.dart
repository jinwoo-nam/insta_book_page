import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_intro.freezed.dart';

part 'book_intro.g.dart';

@freezed
class BookIntro with _$BookIntro {
  factory BookIntro({
    @JsonKey(name: 'issue') @Default("") String issue,
    @JsonKey(name: 'Main Title') @Default("") String main,
    @JsonKey(name: 'Sub Title') @Default("") String sub,
    @JsonKey(name: 'Intro Title') @Default("") String inTitle,
    @JsonKey(name: 'Body') @Default("") String desc,
    @JsonKey(name: 'Author') @Default("") String author,
    @JsonKey(name: 'Color') @Default("") String color,
    @JsonKey(name: 'Opacity') @Default("") String opacity,
  }) = _BookIntro;

  factory BookIntro.fromJson(Map<String, dynamic> json) =>
      _$BookIntroFromJson(json);
}
