import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_data.freezed.dart';

part 'book_data.g.dart';

@freezed
class BookData with _$BookData {
  factory BookData({
    @Default("") String isbn,
    @Default("") String booktitle,
    @Default("") String author,
    @Default("") String publisher,
    @Default("") String pubdate,
    @Default("") String rprice,
    @Default("") String sprice,
    @Default("") String salerate,
    @Default("") String description,
    @Default("") String img,
    @Default("") String post_title,
    @Default("") String post_body,
    @Default("") String comment,
    @Default("") String commenter,
    @Default("") String post_author,
  }) = _BookData;

  factory BookData.fromJson(Map<String, dynamic> json) =>
      _$BookDataFromJson(json);
}
