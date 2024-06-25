import 'package:ai_shapers/features/law/repository/law_repository.dart';
import 'package:ai_shapers/models/article_model.dart';
import 'package:ai_shapers/models/chapter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getArticlesDataByChapterProvider =
    StreamProvider.family((ref, int chapter) {
  return ref
      .watch(lawControllerProvider.notifier)
      .getArticlesDataByChapter(chapter);
});

final getChapterDataProvider = StreamProvider.family((ref, int chapter) {
  return ref.watch(lawControllerProvider.notifier).getChapterData(chapter);
});

final lawControllerProvider = StateNotifierProvider<LawController, bool>(
  (ref) => LawController(
    lawRepository: ref.read(lawRepositoryProvider),
    ref: ref,
  ),
);

class LawController extends StateNotifier<bool> {
  final LawRepository _lawRepository;
  // ignore: unused_field
  final Ref _ref;

  LawController({
    required LawRepository lawRepository,
    required Ref ref,
  })  : _lawRepository = lawRepository,
        _ref = ref,
        super(false);

  Stream<List<Article>> getArticlesDataByChapter(int chapter) {
    return _lawRepository.getArticlesDataByChapter(chapter);
  }

  Stream<Chapter> getChapterData(int chapter) {
    return _lawRepository.getChapterData(chapter);
  }
}
