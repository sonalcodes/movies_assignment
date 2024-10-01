import 'package:assignment/bottom_sheets/show_details_bottom_sheet.dart';
import 'package:assignment/mixins/baseClass.dart';
import 'package:assignment/views/search/search_page.dart';
import 'package:assignment/widgets/circular_indicator.dart';
import 'package:assignment/widgets/floating_action_widget.dart';
import 'package:assignment/widgets/home_horizontal_tile.dart';
import 'package:assignment/widgets/home_vertical_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home/home_controller.dart';

class HomePage extends StatelessWidget with BaseClass {
  HomePage({super.key});

  final TvShowController tvShowController = Get.put(TvShowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionWidget(
        onTap: () {
          pushToNextScreen(destination: SearchMoviePage());
        },
        icon: Icons.search,
      ),
      body: GetBuilder<TvShowController>(
        builder: (controller) {
          if (controller.tvShows.isEmpty && controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: controller.horizontalScrollController,
                  itemCount: controller.tvShows.length +
                      (controller.hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.tvShows.length) {
                      return const CircularIndicator();
                    }
                    return HomeHorizontalTile(
                        showImage: controller.tvShows
                            .elementAt(index)
                            .imageThumbnailPath,
                        onTap: () {
                          if (controller.tvShows
                                  .elementAt(index)
                                  .imageThumbnailPath
                                  ?.isNotEmpty ??
                              false) {
                            TvShowDetailsBottomSheet.showTvDetailsBottomSheet(
                                context: context,
                                image: controller.tvShows
                                        .elementAt(index)
                                        .imageThumbnailPath ??
                                    '');
                          }
                        });
                  },
                ),
              ),

              // Vertical ListView with Pagination
              Expanded(
                child: ListView.builder(
                  controller: controller.verticalScrollController,
                  itemCount: controller.tvShows.length +
                      (controller.hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.tvShows.length) {
                      return const CircularIndicator();
                    }
                    return HomeVerticalTile(
                        showName: controller.tvShows.elementAt(index).name,
                        onTap: () {
                          if (controller.tvShows
                                  .elementAt(index)
                                  .imageThumbnailPath
                                  ?.isNotEmpty ??
                              false) {
                            TvShowDetailsBottomSheet.showTvDetailsBottomSheet(
                                context: context,
                                image: controller.tvShows
                                        .elementAt(index)
                                        .imageThumbnailPath ??
                                    '');
                          }
                        });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
