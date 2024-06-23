// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Article {
  final String title;
  final String content;
  final int chapter;
  Article({
    required this.title,
    required this.content,
    required this.chapter,
  });

  Article copyWith({
    String? title,
    String? content,
    int? chapter,
  }) {
    return Article(
      title: title ?? this.title,
      content: content ?? this.content,
      chapter: chapter ?? this.chapter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'chapter': chapter,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      content: map['content'] as String,
      chapter: map['chapter'] as int,
    );
  }

  @override
  String toString() => 'Article(title: $title, content: $content, chapter: $chapter)';

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.chapter == chapter;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ chapter.hashCode;

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) => Article.fromMap(json.decode(source) as Map<String, dynamic>);
}
