// ignore_for_file: non_constant_identifier_names

import 'package:zippy/domain/model/content.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ContentEntity extends Equatable {
  final int? id;
  final int category_id;
  final String url;
  final String title;
  final int item_index;
  final String author;
  final String? content_text;
  final String? content_img_url;

  const ContentEntity({
    this.id,
    required this.category_id,
    required this.url,
    required this.title,
    required this.item_index,
    required this.author,
    this.content_text,
    this.content_img_url,
  });

  @override
  List<Object> get props {
    return [
      category_id,
      url,
      title,
      item_index,
      author,
    ];
  }

  factory ContentEntity.fromJson(Map<String, dynamic> json) {
    return ContentEntity(
      id: json['id'],
      category_id: json['category_id'],
      url: json['url'],
      title: json['title'],
      item_index: json['item_index'],
      author: json['author'],
      content_text: json['content_text'],
      content_img_url: json['content_img_url'],
    );
  }

  Content toModel() {
    return Content(
        id: id,
        categoryId: category_id,
        url: url,
        title: title,
        itemIndex: item_index,
        author: author,
        contentText: content_text,
        contentImgUrl: content_img_url);
  }
}