import 'package:ai_shapers/core/constants/error_text.dart';
import 'package:ai_shapers/core/constants/loading.dart';
import 'package:ai_shapers/features/law/controller/law_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LawChapterDetailScreen extends ConsumerStatefulWidget {
  const LawChapterDetailScreen({
    super.key,
    required this.chapter,
    this.selectedArticleIndex,
  });

  final int chapter;
  final int? selectedArticleIndex;

  @override
  LawChapterDetailScreenState createState() => LawChapterDetailScreenState();
}

class LawChapterDetailScreenState
    extends ConsumerState<LawChapterDetailScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedArticleIndex != null) {
        _scrollToSelectedArticle(widget.selectedArticleIndex!);
      }
    });
  }

  void _scrollToSelectedArticle(int index) {
    final position = (index * 120.0);
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles =
        ref.watch(getArticlesDataByChapterProvider(widget.chapter));
    final chapter = ref.watch(getChapterDataProvider(widget.chapter));
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
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        color: widget.selectedArticleIndex == index
                            ? Colors.yellow
                            : Colors.white,
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
                              _buildArticleContent(article.content),
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

  Widget _buildArticleContent(String content) {
    List<InlineSpan> spans = [];
    RegExp exp = RegExp(r'(\d+\.\s)');
    Iterable<RegExpMatch> matches = exp.allMatches(content);

    int lastMatchEnd = 0;
    for (var match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: content.substring(lastMatchEnd, match.start).trim(),
          style: const TextStyle(fontSize: 16.0, color: Color(0xFF00001c)),
        ));
      }
      spans.add(TextSpan(
        text: '\n\n${match.group(0)}',
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00001c)),
      ));
      lastMatchEnd = match.end;
    }

    spans.add(TextSpan(
      text: content.substring(lastMatchEnd).trim(),
      style: const TextStyle(fontSize: 16.0, color: Color(0xFF00001c)),
    ));

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
