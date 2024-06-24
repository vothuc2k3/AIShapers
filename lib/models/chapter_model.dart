// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';


class Chapter {
  final int chapterNum;
  final String title;
  final List<String> articles;
  Chapter({
    required this.chapterNum,
    required this.title,
    required this.articles,
  });

  Chapter copyWith({
    int? chapterNum,
    String? title,
    List<String>? articles,
  }) {
    return Chapter(
      chapterNum: chapterNum ?? this.chapterNum,
      title: title ?? this.title,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterNum': chapterNum,
      'title': title,
      'articles': articles,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterNum: map['chapterNum'] as int,
      title: map['title'] as String,
      articles: List<String>.from((map['articles'] as List<String>)),
    );
  }

  @override
  String toString() =>
      'Chapter(chapterNum: $chapterNum, title: $title, articles: $articles)';

  @override
  bool operator ==(covariant Chapter other) {
    if (identical(this, other)) return true;

    return other.chapterNum == chapterNum &&
        other.title == title &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode => chapterNum.hashCode ^ title.hashCode ^ articles.hashCode;

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);
}
