// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Article {
  final String title;
  final String content;
  final int chapter;
  final int article;
  Article({
    required this.title,
    required this.content,
    required this.chapter,
    required this.article,
  });

  Article copyWith({
    String? title,
    String? content,
    int? chapter,
    int? article,
  }) {
    return Article(
      title: title ?? this.title,
      content: content ?? this.content,
      chapter: chapter ?? this.chapter,
      article: article ?? this.article,
      
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'chapter': chapter,
      'article': article,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      content: map['content'] as String,
      chapter: map['chapter'] as int,
      article: map['article'] as int,
    );
  }

  @override
  String toString() {
    return 'Article(title: $title, content: $content, chapter: $chapter, article: $article)';
  }

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.chapter == chapter &&
      other.article == article;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      content.hashCode ^
      chapter.hashCode ^
      article.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) => Article.fromMap(json.decode(source) as Map<String, dynamic>);
}
