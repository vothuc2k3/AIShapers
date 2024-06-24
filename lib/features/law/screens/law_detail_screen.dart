import 'package:ai_shapers/core/constants/error_text.dart';
import 'package:ai_shapers/core/constants/loading.dart';
import 'package:ai_shapers/features/law/controller/law_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LawChapterDetailScreen extends ConsumerStatefulWidget {
  const LawChapterDetailScreen({
    super.key,
    required int chapter,
  }) : _chapter = chapter;

  final int _chapter;

  @override
  LawChapterDetailScreenState createState() => LawChapterDetailScreenState();
}

class LawChapterDetailScreenState
    extends ConsumerState<LawChapterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final articles =
        ref.watch(getArticlesDataByChapterProvider(widget._chapter));
    final chapter = ref.watch(getChapterData(widget._chapter));
    return chapter.when(
      data: (chapter) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF00001c),
            title: Text(
              'Chương ${chapter.chapterNum}: ${chapter.title}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: articles.when(
            data: (articles) {
              return Container(
                color: const Color(0xFF00001c),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Điều ${article.article}: ${article.title}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00001c),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                article.content,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Color(0xFF00001c)),
                              ),
                            ],
                          ),
                        ),
                      ),
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
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: ErrorText(error: error.toString()),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: Loading(),
        ),
      ),
    );
  }
}
