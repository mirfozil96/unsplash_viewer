import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";

import "../../../../../riverpod.dart";
import "../../view_model/data/entity/get_all_image_model.dart";
import "../../view_model/data/repository/main_repo.dart";

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                final AsyncValue<void> con = ref.watch(mainFetchData);
                return con.when(
                  data: (void data) {
                    final List<GetAllImageModel> images =
                        ref.read(mainVM).allImages;
                    if (images.isEmpty) {
                      return const Text("No images available");
                    }
                    return MasonryGridView.count(
                      controller: ref.read(mainVM).scrollController,
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: images.length,
                      itemBuilder: (_, int index) {
                        final GetAllImageModel image = images[index];
                        return Card(
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                image.urls?.small ??
                                    "https://ralfvanveen.com/wp-content/uploads/2021/06/Placeholder-_-Glossary.svg",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(image.altDescription ?? "No name"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (Object error, StackTrace stackTrace) =>
                      Text("Error: $error"),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
            Visibility(
              visible: ref.watch(mainVM).isLoading,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
