// ignore_for_file: non_constant_identifier_names

import 'package:zippy/app/failures/failure.dart';
import 'package:zippy/data/entity/user_bookmark_entity.dart';
import 'package:zippy/data/providers/hive_provider.dart';
import 'package:zippy/data/sources/interfaces/user_bookmark_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:zippy/domain/model/user_bookmark.dart';

enum UserBookmarkKey {
  all('전체보기'),
  ;

  const UserBookmarkKey(this.name);
  final String name;
}

class UserBookmarkDatasourceImpl implements UserBookmarkDatasource {
  var box = Get.find<HiveProvider>().userBookMarks!;

  @override
  Future<Either<Failure, List<UserBookmark>>> createBookmark(
      UserBookmarkEntity newBookmark) async {
    try {
      List<dynamic> bookmarks = _getBookmarks();

      bookmarks.add(newBookmark);

      await box.put(UserBookmarkKey.all.name, bookmarks);

      return Right(toBookmarkModelAll());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserBookmark>>> deleteBookmark(
      UserBookmarkEntity removeBookmark) async {
    try {
      List<dynamic> bookmarks = _getBookmarks();

      bookmarks.removeWhere((bookmark) => bookmark.id == removeBookmark.id);
      await box.put(UserBookmarkKey.all.name, bookmarks);

      return Right(toBookmarkModelAll());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserBookmark>>> getBookmarks() async {
    try {
      return Right(toBookmarkModelAll());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<List<UserBookmark>> subscribeUserBookmarks() {
    return box.watch().map((event) {
      return toBookmarkModelAll();
    });
  }

  List<dynamic> _getBookmarks() {
    return box.get(UserBookmarkKey.all.name, defaultValue: []);
  }

  List<UserBookmark> toBookmarkModelAll() {
    return _getBookmarks()
        .map((bookmark) => UserBookmark(
            id: bookmark.id,
            url: bookmark.url,
            title: bookmark.title,
            contentText: bookmark.contentText,
            contentImgUrl: bookmark.contentImgUrl))
        .toList();
  }
}
