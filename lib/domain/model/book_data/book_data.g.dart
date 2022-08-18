// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookData _$$_BookDataFromJson(Map<String, dynamic> json) => _$_BookData(
      isbn: json['isbn'] as String? ?? "",
      booktitle: json['booktitle'] as String? ?? "",
      author: json['author'] as String? ?? "",
      publisher: json['publisher'] as String? ?? "",
      pubdate: json['pubdate'] as String? ?? "",
      rprice: json['rprice'] as String? ?? "",
      sprice: json['sprice'] as String? ?? "",
      salerate: json['salerate'] as String? ?? "",
      description: json['description'] as String? ?? "",
      img: json['img'] as String? ?? "",
      post_title: json['post_title'] as String? ?? "",
      post_body: json['post_body'] as String? ?? "",
      comment: json['comment'] as String? ?? "",
      commenter: json['commenter'] as String? ?? "",
      post_author: json['post_author'] as String? ?? "",
    );

Map<String, dynamic> _$$_BookDataToJson(_$_BookData instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'booktitle': instance.booktitle,
      'author': instance.author,
      'publisher': instance.publisher,
      'pubdate': instance.pubdate,
      'rprice': instance.rprice,
      'sprice': instance.sprice,
      'salerate': instance.salerate,
      'description': instance.description,
      'img': instance.img,
      'post_title': instance.post_title,
      'post_body': instance.post_body,
      'comment': instance.comment,
      'commenter': instance.commenter,
      'post_author': instance.post_author,
    };
