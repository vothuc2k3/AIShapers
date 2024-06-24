import 'package:ai_shapers/models/article_model.dart';
import 'package:ai_shapers/models/chapter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_shapers/core/providers/firebase_providers.dart';

final lawRepositoryProvider = Provider(
  (ref) {
    return LawRepository(
      firestore: ref.read(firebaseFirestoreProvider),
    );
  },
);

class LawRepository {
  final FirebaseFirestore _firestore;

  LawRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Stream<List<Article>> getArticlesDataByChapter(int chapter) {
    return _firestore
        .collection('article')
        .where('chapterNum', isEqualTo: chapter)
        .snapshots()
        .map((event) {
      List<Article> articles = [];
      for (var doc in event.docs) {
        articles.add(
          Article(
            title: doc['title'] as String,
            content: doc['content'] as String,
            chapter: chapter,
            article: doc['articleNum'] as int,
          ),
        );
      }
      return articles;
    });
  }

  Stream<Chapter> getChapterData(int chapter) {
    return _firestore
        .collection('chapter')
        .where('chapterNum', isEqualTo: chapter)
        .snapshots()
        .map((event) {
      final returnChapter = [];
      for (var doc in event.docs) {
        final docData = doc.data();
        returnChapter.add(
          Chapter(
            chapterNum: chapter,
            title: docData['title'] as String,
            articles: List<String>.from(docData['articles']),
          ),
        );
      }
      return returnChapter.first;
    });
  }
}
