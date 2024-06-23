class Chapter {
  final String chapterId;
  final String title;
  Chapter({
    required this.chapterId,
    required this.title,
  });

  Chapter copyWith({
    String? chapterId,
    String? title,
  }) {
    return Chapter(
      chapterId: chapterId ?? this.chapterId,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterId': chapterId,
      'title': title,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterId: map['chapterId'] as String,
      title: map['title'] as String,
    );
  }

  @override
  String toString() => 'Chapter(chapterId: $chapterId, title: $title)';

  @override
  bool operator ==(covariant Chapter other) {
    if (identical(this, other)) return true;

    return other.chapterId == chapterId && other.title == title;
  }

  @override
  int get hashCode => chapterId.hashCode ^ title.hashCode;
}
