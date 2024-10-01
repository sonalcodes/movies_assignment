import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/search/search_model.dart';
import '../../network_services/api_service.dart';

class SearchMovieController extends GetxController {
  var isLoading = false;
  List<TvShowModel> tvShows = [];
  var searchValue = '';
  var page = 1;
  var totalResults = 0;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreResults();
      }
    });
  }

  void clearResults() {
    tvShows.clear();
    page = 1;
    totalResults = 0;
    update(); // Update the UI to reflect the cleared results
  }

  void resetSearch() {
    searchValue = '';
    clearResults();
  }

  Future<void> searchTvShows(String value) async {
    if (value.isEmpty) {
      clearResults(); // Clear results when query is empty
      return;
    }
    isLoading = true;
    update();
    try {
      final response = await ApiService.get('search?q=$value&page=$page');
      List tvShowsList = response['tv_shows'];

      if (page == 1) {
        tvShows =
            tvShowsList.map((show) => TvShowModel.fromJson(show)).toList();
      } else {
        tvShows.addAll(
            tvShowsList.map((show) => TvShowModel.fromJson(show)).toList());
      }

      totalResults = int.parse(response['total']);

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      throw e.toString();
    }
  }

  void loadMoreResults() {
    if (!isLoading && tvShows.length < totalResults) {
      page += 1;
      searchTvShows(searchValue);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
