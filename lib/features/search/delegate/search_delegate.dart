import 'package:ai_shapers/core/constants/error_text.dart';
import 'package:ai_shapers/core/constants/loading.dart';
import 'package:ai_shapers/features/law/controller/law_controller.dart';
import 'package:ai_shapers/features/law/screens/law_detail_screen.dart';
import 'package:ai_shapers/features/search/controller/search_controller.dart';
import 'package:ai_shapers/models/article_model.dart';
import 'package:ai_shapers/models/chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchLawDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchLawDelegate(this.ref);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF00001c),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF00001c),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchResults = ref.watch(searchProvider(query));
        return searchResults.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text(
                  'Không tìm thấy điều luật nào.....',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Article article = data[index];
                final AsyncValue<Chapter> chapter =
                    ref.watch(getChapterDataProvider(article.chapter));
                return chapter.when(
                  data: (chapter) {
                    return Card(
                      color: Colors.black87,
                      margin: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            'https://via.placeholder.com/150',
                          ),
                        ),
                        title: Text(
                          'Điều ${article.article}: ${article.title}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Chương: ${article.chapter}: ${chapter.title}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigateToChapterDetailScreen(
                            context,
                            article.chapter,
                            article.article,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: ErrorText(error: error.toString()),
                  ),
                  loading: () => const Center(
                    child: Loading(),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
            );
          },
          error: (error, stackTrace) => Center(
            child: ErrorText(error: error.toString()),
          ),
          loading: () => const Center(
            child: Loading(),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchResults = ref.watch(searchProvider(query));
        return searchResults.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text(
                  'Không tìm thấy điều luật nào.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Article article = data[index];
                final AsyncValue<Chapter> chapter =
                    ref.watch(getChapterDataProvider(article.chapter));
                return chapter.when(
                  data: (chapter) {
                    return Card(
                      color: Colors.black87,
                      margin: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            'https://via.placeholder.com/150',
                          ),
                        ),
                        title: Text(
                          'Điều ${article.article}: ${article.title}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Chương: ${article.chapter}: ${chapter.title}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigateToChapterDetailScreen(
                            context,
                            article.chapter,
                            article.article,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: ErrorText(error: error.toString()),
                  ),
                  loading: () => const Center(
                    child: Loading(),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
            );
          },
          error: (error, stackTrace) => Center(
            child: ErrorText(error: error.toString()),
          ),
          loading: () => const Center(
            child: Loading(),
          ),
        );
      },
    );
  }

  void navigateToChapterDetailScreen(context, int chapter, int articleNum) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LawChapterDetailScreen(
          chapter: chapter,
          selectedArticleIndex: articleNum - 1,
        ),
      ),
    );
  }
}
