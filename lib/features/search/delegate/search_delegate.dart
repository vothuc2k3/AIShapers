import 'package:ai_shapers/core/constants/error_text.dart';
import 'package:ai_shapers/core/constants/loading.dart';
import 'package:ai_shapers/features/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchLawDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchLawDelegate(this.ref);

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
    return const SizedBox();
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
                  'No articles found.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final article = data[index];
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
                      article.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      article.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {},
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loading(),
        );
      },
    );
  }
}
