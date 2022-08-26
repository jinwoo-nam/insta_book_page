// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HomeState _$HomeStateFromJson(Map<String, dynamic> json) {
  return _HomeState.fromJson(json);
}

/// @nodoc
mixin _$HomeState {
  bool get isGoogleSheetLoading => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<BookIntro> get bookIntroList => throw _privateConstructorUsedError;
  BookIntro? get curBookInfo => throw _privateConstructorUsedError;
  List<BookData> get curBookData => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<Map<String, List<BookData>>> get totalBookData =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call(
      {bool isGoogleSheetLoading,
      bool isLoading,
      List<BookIntro> bookIntroList,
      BookIntro? curBookInfo,
      List<BookData> curBookData,
      String imageUrl,
      List<Map<String, List<BookData>>> totalBookData});

  $BookIntroCopyWith<$Res>? get curBookInfo;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object? isGoogleSheetLoading = freezed,
    Object? isLoading = freezed,
    Object? bookIntroList = freezed,
    Object? curBookInfo = freezed,
    Object? curBookData = freezed,
    Object? imageUrl = freezed,
    Object? totalBookData = freezed,
  }) {
    return _then(_value.copyWith(
      isGoogleSheetLoading: isGoogleSheetLoading == freezed
          ? _value.isGoogleSheetLoading
          : isGoogleSheetLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      bookIntroList: bookIntroList == freezed
          ? _value.bookIntroList
          : bookIntroList // ignore: cast_nullable_to_non_nullable
              as List<BookIntro>,
      curBookInfo: curBookInfo == freezed
          ? _value.curBookInfo
          : curBookInfo // ignore: cast_nullable_to_non_nullable
              as BookIntro?,
      curBookData: curBookData == freezed
          ? _value.curBookData
          : curBookData // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookData: totalBookData == freezed
          ? _value.totalBookData
          : totalBookData // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<BookData>>>,
    ));
  }

  @override
  $BookIntroCopyWith<$Res>? get curBookInfo {
    if (_value.curBookInfo == null) {
      return null;
    }

    return $BookIntroCopyWith<$Res>(_value.curBookInfo!, (value) {
      return _then(_value.copyWith(curBookInfo: value));
    });
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isGoogleSheetLoading,
      bool isLoading,
      List<BookIntro> bookIntroList,
      BookIntro? curBookInfo,
      List<BookData> curBookData,
      String imageUrl,
      List<Map<String, List<BookData>>> totalBookData});

  @override
  $BookIntroCopyWith<$Res>? get curBookInfo;
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, (v) => _then(v as _$_HomeState));

  @override
  _$_HomeState get _value => super._value as _$_HomeState;

  @override
  $Res call({
    Object? isGoogleSheetLoading = freezed,
    Object? isLoading = freezed,
    Object? bookIntroList = freezed,
    Object? curBookInfo = freezed,
    Object? curBookData = freezed,
    Object? imageUrl = freezed,
    Object? totalBookData = freezed,
  }) {
    return _then(_$_HomeState(
      isGoogleSheetLoading: isGoogleSheetLoading == freezed
          ? _value.isGoogleSheetLoading
          : isGoogleSheetLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      bookIntroList: bookIntroList == freezed
          ? _value._bookIntroList
          : bookIntroList // ignore: cast_nullable_to_non_nullable
              as List<BookIntro>,
      curBookInfo: curBookInfo == freezed
          ? _value.curBookInfo
          : curBookInfo // ignore: cast_nullable_to_non_nullable
              as BookIntro?,
      curBookData: curBookData == freezed
          ? _value._curBookData
          : curBookData // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookData: totalBookData == freezed
          ? _value._totalBookData
          : totalBookData // ignore: cast_nullable_to_non_nullable
              as List<Map<String, List<BookData>>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HomeState implements _HomeState {
  _$_HomeState(
      {this.isGoogleSheetLoading = false,
      this.isLoading = true,
      final List<BookIntro> bookIntroList = const [],
      this.curBookInfo,
      final List<BookData> curBookData = const [],
      this.imageUrl = '',
      final List<Map<String, List<BookData>>> totalBookData = const []})
      : _bookIntroList = bookIntroList,
        _curBookData = curBookData,
        _totalBookData = totalBookData;

  factory _$_HomeState.fromJson(Map<String, dynamic> json) =>
      _$$_HomeStateFromJson(json);

  @override
  @JsonKey()
  final bool isGoogleSheetLoading;
  @override
  @JsonKey()
  final bool isLoading;
  final List<BookIntro> _bookIntroList;
  @override
  @JsonKey()
  List<BookIntro> get bookIntroList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookIntroList);
  }

  @override
  final BookIntro? curBookInfo;
  final List<BookData> _curBookData;
  @override
  @JsonKey()
  List<BookData> get curBookData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_curBookData);
  }

  @override
  @JsonKey()
  final String imageUrl;
  final List<Map<String, List<BookData>>> _totalBookData;
  @override
  @JsonKey()
  List<Map<String, List<BookData>>> get totalBookData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_totalBookData);
  }

  @override
  String toString() {
    return 'HomeState(isGoogleSheetLoading: $isGoogleSheetLoading, isLoading: $isLoading, bookIntroList: $bookIntroList, curBookInfo: $curBookInfo, curBookData: $curBookData, imageUrl: $imageUrl, totalBookData: $totalBookData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            const DeepCollectionEquality()
                .equals(other.isGoogleSheetLoading, isGoogleSheetLoading) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other._bookIntroList, _bookIntroList) &&
            const DeepCollectionEquality()
                .equals(other.curBookInfo, curBookInfo) &&
            const DeepCollectionEquality()
                .equals(other._curBookData, _curBookData) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._totalBookData, _totalBookData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isGoogleSheetLoading),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(_bookIntroList),
      const DeepCollectionEquality().hash(curBookInfo),
      const DeepCollectionEquality().hash(_curBookData),
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(_totalBookData));

  @JsonKey(ignore: true)
  @override
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeStateToJson(
      this,
    );
  }
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {final bool isGoogleSheetLoading,
      final bool isLoading,
      final List<BookIntro> bookIntroList,
      final BookIntro? curBookInfo,
      final List<BookData> curBookData,
      final String imageUrl,
      final List<Map<String, List<BookData>>> totalBookData}) = _$_HomeState;

  factory _HomeState.fromJson(Map<String, dynamic> json) =
      _$_HomeState.fromJson;

  @override
  bool get isGoogleSheetLoading;
  @override
  bool get isLoading;
  @override
  List<BookIntro> get bookIntroList;
  @override
  BookIntro? get curBookInfo;
  @override
  List<BookData> get curBookData;
  @override
  String get imageUrl;
  @override
  List<Map<String, List<BookData>>> get totalBookData;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
