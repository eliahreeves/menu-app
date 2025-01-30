import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/custom_widgets/time_state_display.dart';
import 'package:menu_app/providers/college_list_provider.dart';
import 'package:menu_app/providers/summary_list_provider.dart';
import 'package:menu_app/providers/waitz_crowd_status.dart';
import 'package:menu_app/utilities/constants.dart' as constants;
import 'package:menu_app/views/error_widget.dart';

class SummaryList extends ConsumerWidget {
  final String mealTime;
  const SummaryList({super.key, required this.mealTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colleges = ref.watch(collegeListProvider);
    final waitz = ref.watch(waitzCrowdStatusProvider);
    final summaries = ref.watch(summaryListDataProvider(mealTime));
    if (summaries.hasError) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   showOverlay(context);
      // });
      
    }
    return Column(
      children: <Widget>[
        for (int index = 0;
            index < colleges.length && index < colleges.length;
            index++)
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            alignment: Alignment.topLeft,
            child: TextButton(
              // Give each [college] a button to lead to the full summary page.
              onPressed: () {
                context.push(colleges[index].pathName);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primaryContainer),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Text(
                            colleges[index].name,
                            style: constants.containerTextStyle,
                          ),
                        ),
                        TimeStateDisplay(
                          name: colleges[index].id,
                          waitzNum: waitz.when(
                            data: (data) => data[colleges[index].id],
                            loading: () => null,
                            error: (error, _) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    if (summaries.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    // Check if snapshot data is not null before accessing its elements
                    else if (summaries.hasValue &&
                        summaries.value !=
                            null) // Display all the food categories and items.
                      if (summaries.value![index].foodItems.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var foodItem
                                in summaries.value![index].foodItems)
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  foodItem.name,
                                  textAlign: TextAlign.left,
                                  style: constants.containerTextStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: constants.bodyFont,
                                    fontSize: constants.bodyFontSize,
                                    height: constants.bodyFontheight,
                                  ),
                                ),
                              ),
                          ],
                        )
                      else if (summaries.hasError)
                        Container(
                          padding: const EdgeInsets.only(
                              top: constants.containerPaddingbody),
                          alignment: Alignment.center,
                          child: Text(
                            "Could not connect... Please retry.",
                            textAlign: TextAlign.center,
                            style: constants.containerTextStyle.copyWith(
                              fontFamily: constants.bodyFont,
                              fontSize: constants.bodyFontSize,
                              height: constants.bodyFontheight,
                            ),
                          ),
                        )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
