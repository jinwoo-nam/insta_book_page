// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_intro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookIntro _$$_BookIntroFromJson(Map<String, dynamic> json) => _$_BookIntro(
      issue: json['issue'] as String? ?? "",
      main: json['Main Title'] as String? ?? "",
      sub: json['Sub Title'] as String? ?? "",
      inTitle: json['Intro Title'] as String? ?? "",
      desc: json['Body'] as String? ?? "",
      author: json['Author'] as String? ?? "",
      color: json['Color'] as String? ?? "",
      opacity: json['Opacity'] as String? ?? "",
    );

Map<String, dynamic> _$$_BookIntroToJson(_$_BookIntro instance) =>
    <String, dynamic>{
      'issue': instance.issue,
      'Main Title': instance.main,
      'Sub Title': instance.sub,
      'Intro Title': instance.inTitle,
      'Body': instance.desc,
      'Author': instance.author,
      'Color': instance.color,
      'Opacity': instance.opacity,
    };
