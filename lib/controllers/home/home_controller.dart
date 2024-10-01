import 'package:assignment/network_services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/home/home_model.dart';

class TvShowController extends GetxController {
  List<TvShow> tvShows = [];
  bool isLoading = false;
  bool hasMoreData = true;
  int page = 1;

  ScrollController horizontalScrollController = ScrollController();
  ScrollController verticalScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchTvShows();
    horizontalScrollController.addListener(() {
      if (horizontalScrollController.position.pixels ==
          horizontalScrollController.position.maxScrollExtent) {
        fetchTvShows();
      }
    });
    verticalScrollController.addListener(() {
      if (verticalScrollController.position.pixels ==
              verticalScrollController.position.maxScrollExtent &&
          hasMoreData) {
        fetchTvShows();
      }
    });
  }

  Future<void> fetchTvShows() async {
    try {
      if (isLoading || !hasMoreData) return;

      isLoading = true;
      update();
      final response = await ApiService.get('most-popular?page=$page');
      List newShows = response['tv_shows'];
      if (newShows.isNotEmpty) {
        tvShows.addAll(newShows.map((show) => TvShow.fromJson(show)).toList());
        page++;
      } else {
        hasMoreData = false;
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      throw e.toString();
    }
  }

  @override
  void onClose() {
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    super.onClose();
  }
}
