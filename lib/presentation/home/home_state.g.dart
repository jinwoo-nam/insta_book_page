// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomeState _$$_HomeStateFromJson(Map<String, dynamic> json) => _$_HomeState(
      isGoogleSheetLoading: json['isGoogleSheetLoading'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? true,
      bookIntroList: (json['bookIntroList'] as List<dynamic>?)
              ?.map((e) => BookIntro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      curBookInfo: json['curBookInfo'] == null
          ? null
          : BookIntro.fromJson(json['curBookInfo'] as Map<String, dynamic>),
      curBookData: (json['curBookData'] as List<dynamic>?)
              ?.map((e) => BookData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrl: json['imageUrl'] as String? ?? '',
      totalBookData: (json['totalBookData'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(
                        k,
                        (e as List<dynamic>)
                            .map((e) =>
                                BookData.fromJson(e as Map<String, dynamic>))
                            .toList()),
                  ))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_HomeStateToJson(_$_HomeState instance) =>
    <String, dynamic>{
      'isGoogleSheetLoading': instance.isGoogleSheetLoading,
      'isLoading': instance.isLoading,
      'bookIntroList': instance.bookIntroList,
      'curBookInfo': instance.curBookInfo,
      'curBookData': instance.curBookData,
      'imageUrl': instance.imageUrl,
      'totalBookData': instance.totalBookData,
    };
