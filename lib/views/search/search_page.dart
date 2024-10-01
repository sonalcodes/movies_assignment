import 'package:assignment/widgets/circular_indicator.dart';
import 'package:assignment/widgets/form_input_with_hint_on_top.dart';
import 'package:assignment/widgets/home_horizontal_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/search/search_controller.dart';

class SearchMoviePage extends StatelessWidget {
  SearchMoviePage({super.key});

  final SearchMovieController searchController =
      Get.put(SearchMovieController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        searchController.resetSearch();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Input Field
              FormInputWithHint(
                hintText: 'Search Movie',
                suffixIcon: const Icon(Icons.search),
                onChanged: (String value) {
                  searchController.searchValue = value;
                  if (value.isNotEmpty) {
                    searchController.page = 1;
                    searchController.searchTvShows(value);
                  }
                },
              ),
              const SizedBox(height: 16),

              Expanded(
                child: GetBuilder<SearchMovieController>(
                  builder: (controller) {
                    if (controller.isLoading && controller.tvShows.isEmpty) {
                      return const CircularIndicator();
                    }
                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.tvShows.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.tvShows.length) {
                          return controller.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }

                        return HomeHorizontalTile(
                            width: double.infinity,
                            height: Get.height * 0.4,
                            showImage: controller.tvShows
                                .elementAt(index)
                                .imageThumbnailPath??'',
                            onTap: () {});
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
