import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/providers/banner_text_provider.dart';
import 'package:menu_app/providers/meal_album_provider.dart';
import 'package:menu_app/providers/summary_list_provider.dart';
import 'package:menu_app/providers/update_time_provider.dart';
import 'package:menu_app/providers/waitz_crowd_status.dart';
import 'package:menu_app/utilities/constants.dart' as constants;
import 'package:menu_app/views/nutrition_page.dart';

// FIXME to controller
class MealDisplayWidegt extends ConsumerWidget {
  final String hallName;
  final String mealTime;
  final String day;
  const MealDisplayWidegt(
      {super.key,
      required this.hallName,
      required this.mealTime,
      this.day = "Today"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAlbum =
        ref.watch(mealAlbumProvider(hallName, mealTime, day: day));
    return RefreshIndicator(
        onRefresh: () async {
          if (mealAlbum.isLoading) {
            return;
          }
          ref.invalidate(mealAlbumProvider);
          ref.invalidate(summaryListDataProvider);
          ref.invalidate(waitzCrowdStatusProvider);
          ref.invalidate(bannerTextProvider);
          ref.invalidate(updateTimeProvider);
        },
        child: mealAlbum.when(
            data: (value) {
              if (value[0].foodItems.isEmpty) {
                return SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.topCenter,
                    child: Text('Hall Closed',
                        style: constants.containerTextStyle),
                  ),
                );

                // Display the food categories and food items.
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: constants.containerPaddingTitle),
                  itemCount: value.length + 1,
                  itemBuilder: (context, index) {
                    if (index == value.length) {
                      return const SizedBox(height: 70);
                    }
                    final category = value[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                          left: 14, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display the food category.
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                category.category,
                                style: constants.containerTextStyle.copyWith(
                                  fontSize: constants.titleFontSize - 2,
                                ),
                              ),
                            ),
                            // Display the food items.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: category.foodItems.map((foodItem) {
                                return InkWell(
                                    onTap: () {
                                      // context.pushNamed(
                                      //   "Nutrition",
                                      //   extra: foodItem,
                                      // );
                                      // FIXME gorouter no worky?
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              NutritionPage(foodItem: foodItem),
                                        ),
                                      );
                                    },
                                    child: Row(children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            foodItem.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: constants.containerTextStyle
                                                .copyWith(
                                                    fontSize:
                                                        constants.bodyFontSize -
                                                            2,
                                                    height: constants
                                                        .bodyFontheight,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      for (String allergy
                                          in foodItem.nutritionalInfo.tags)
                                        // TODO FIXME when eric fixes scraper
                                        if (allergy != "")
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 2),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'icons/${allergy.toLowerCase()}',
                                                isAntiAlias: true,
                                                fit: BoxFit.contain,
                                                scale: 1.25,
                                              ),
                                            ),
                                          ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 13,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ]));
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            error: (_, __) => SingleChildScrollView(
                    child: Container(
                  padding: const EdgeInsets.only(
                      top: constants.containerPaddingbody),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Could not connect... Please retry.",
                    textAlign: TextAlign.center,
                    style: constants.containerTextStyle.copyWith(
                      fontFamily: constants.bodyFont,
                      fontSize: constants.bodyFontSize,
                      height: constants.bodyFontheight,
                    ),
                  ),
                )),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
