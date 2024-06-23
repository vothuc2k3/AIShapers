class Law {
  final String name;
  final String title;
  final String issueDate;
  final String description;
  Law({
    required this.name,
    required this.title,
    required this.issueDate,
    required this.description,
  });

  Law copyWith({
    String? name,
    String? title,
    String? issueDate,
    String? description,
  }) {
    return Law(
      name: name ?? this.name,
      title: title ?? this.title,
      issueDate: issueDate ?? this.issueDate,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'title': title,
      'issueDate': issueDate,
      'description': description,
    };
  }

  factory Law.fromMap(Map<String, dynamic> map) {
    return Law(
      name: map['name'] as String,
      title: map['title'] as String,
      issueDate: map['issueDate'] as String,
      description: map['description'] as String,
    );
  }

  @override
  String toString() {
    return 'Law(name: $name, title: $title, issueDate: $issueDate, description: $description)';
  }

  @override
  bool operator ==(covariant Law other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.title == title &&
        other.issueDate == issueDate &&
        other.description == description;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        title.hashCode ^
        issueDate.hashCode ^
        description.hashCode;
  }
}
