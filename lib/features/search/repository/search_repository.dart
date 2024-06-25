import 'dart:async';

import 'package:ai_shapers/core/constants/firebase_constants.dart';
import 'package:ai_shapers/core/providers/firebase_providers.dart';
import 'package:ai_shapers/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider(
  (ref) {
    return SearchRepository(
      firestore: ref.watch(firebaseFirestoreProvider),
    );
  },
);

class SearchRepository {
  final FirebaseFirestore _firestore;

  SearchRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Stream<List<Article>?> search(String query) {
    if (query.isEmpty) {
      return Stream.value([]);
    }
    return _article
        .where(
          'content',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      return event.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Article(
          title: data['title'] as String,
          content: data['content'] as String,
          chapter: data['chapterNum'] as int,
          article: data['articleNum'] as int,
        );
      }).toList();
    });
  }

  CollectionReference get _article =>
      _firestore.collection(FirebaseConstants.lawArticleCollection);
}
