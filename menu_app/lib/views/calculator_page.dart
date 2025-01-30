import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu_app/providers/balance_provider.dart';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:menu_app/views/calculator_widgets.dart';
import 'package:menu_app/views/error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:menu_app/utilities/prefs_service.dart';
import 'package:menu_app/views/nav_drawer.dart';
import '../utilities/constants.dart' as constants;
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calculator extends ConsumerStatefulWidget {
  const Calculator({super.key});

  @override
  ConsumerState<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<Calculator>
    with SingleTickerProviderStateMixin {
  String calculateDate() {
    // Quarter end estimated
    final DateTime winter = DateTime(DateTime.now().year, 3, 24);
    final DateTime spring = DateTime(DateTime.now().year, 6, 15);
    final DateTime summer = DateTime(DateTime.now().year, 9, 1);
    final DateTime fall = DateTime(DateTime.now().year, 12, 9);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    DateTime chosenDate;

    if (winter.isAfter(now)) {
      chosenDate = winter;
    } else if (spring.isAfter(now)) {
      chosenDate = spring;
    } else if (summer.isAfter(now)) {
      chosenDate = summer;
    } else if (fall.isAfter(now)) {
      chosenDate = fall;
    } else {
      chosenDate = now;
    }

    PrefsService.instance
        .setString('lastChosenDate', formatter.format(chosenDate));

    return formatter.format(chosenDate);
  }

  changeAdVar(value) {
    final prefs = PrefsService.instance;
    prefs.setBool('showAd', value);
  }

  void _loadPreviousValues() async {
    SharedPreferencesWithCache prefs = PrefsService.instance;

    // Date only changes if the current date occurs after the previous stored value
    String? storedDate = prefs.getString('lastChosenDate');
    String dateToDisplay;

    if (storedDate != null) {
      DateTime storedDateTime = DateTime.parse(storedDate);
      if (storedDateTime.isAfter(DateTime.now())) {
        dateToDisplay = storedDate;
      } else {
        dateToDisplay = calculateDate();
      }
    } else {
      dateToDisplay = calculateDate();
    }

    setState(() {
      totalSlugPointsController.text =
          '${prefs.getDouble('totalSlugPoints') ?? 1000.0}';
      mealDayController.text = '${prefs.getDouble('mealDay') ?? 3.0}';
      mealCostController.text = '${prefs.getDouble('mealCost') ?? 12.23}';
      dateController.text = dateToDisplay;
    });
  }

  static const totalSlugPoints = 1000.0;
  static const mealDay = 3.0;
  static const mealCost = 12.23;

  final totalSlugPointsController =
      TextEditingController(text: totalSlugPoints.toString());
  final mealDayController = TextEditingController(text: mealDay.toString());
  final mealCostController = TextEditingController(text: mealCost.toString());
  final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..stop();

  @override
  void initState() {
    super.initState();
    _loadPreviousValues();
  }

  @override
  void dispose() {
    _controller.dispose();
    totalSlugPointsController.dispose();
    mealDayController.dispose();
    mealCostController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // prefetch the balance
    // FIXME this needs to change so that the user can login if the balance is null
    // FIXME i think balance should probably return a stream like barcode so it can load or fail to redirect the user
    // final balance = ref.watch(getBalanceProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _timeModalBottom(context);
          },
          shape: const CircleBorder(),
          enableFeedback: true,
          backgroundColor: const Color.fromARGB(255, 94, 94, 94),
          child: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ),
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: Text(
            "Calculator",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: constants.menuHeadingSize,
                fontFamily: 'Monoton',
                color: Theme.of(context).colorScheme.primary),
          ),
          toolbarHeight: 60,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 4)),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Center(
            child: Form(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: totalSlugPointsController,
                              label: 'Slug points',
                              hint: 'Balance',
                              onChanged: (s) {
                                setState(() {});
                                double? val = double.tryParse(s);
                                if (val != null) {
                                  final prefs = PrefsService.instance;
                                  prefs.setDouble('totalSlugPoints', val);
                                  if (val == 27182818.0) {
                                    changeAdVar(false);
                                  } else if (val == 31415926.0) {
                                    changeAdVar(true);
                                  }
                                }
                              },
                              icon: Icon(
                                LucideIcons.wallet,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              _controller.repeat();

                              attempt() async {
                                ref.invalidate(getBalanceProvider);
                                final balance =
                                    await ref.read(getBalanceProvider.future);
                                final prefs = PrefsService.instance;
                                prefs.setDouble('totalSlugPoints', balance);
                                setState(() {
                                  totalSlugPointsController.text =
                                      balance.toString();
                                });
                              }

                              try {
                                await attempt();
                              } catch (e) {
                                // Handle the exception, e.g., show an error message
                                if (ref.read(authNotifierProvider).sessionId !=
                                    null) {
                                  await ref
                                      .read(authNotifierProvider.notifier)
                                      .authenticateWithPin();
                                  try {
                                    await attempt();
                                  } catch (e) {
                                    // if (context.mounted) {
                                    //   showOverlay(context);
                                    // }
                                  }
                                } else {
                                  if (context.mounted) {
                                    await ref
                                        .read(authNotifierProvider.notifier)
                                        .login(context);
                                    try {
                                      await attempt();
                                    } catch (e) {
                                      // if (context.mounted) {
                                      //   showOverlay(context);
                                      // }
                                    }
                                  } else {
                                    // if (context.mounted) {
                                    //   showOverlay(context);
                                    // }
                                  }
                                }
                              }

                              _controller.stop();
                            },
                            icon: AnimatedBuilder(
                              animation: _controller,
                              child: Icon(
                                LucideIcons.refresh_ccw,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              builder: (BuildContext context, Widget? child) {
                                return Transform.rotate(
                                  angle: _controller.value * -2.0 * math.pi,
                                  child: child,
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CustomTextFormField(
                  //         controller: totalSlugPointsController,
                  //         label: 'Slug points',
                  //         hint: 'Balance',
                  //         onChanged: (s) {
                  //           setState(() {});
                  //           double? val = double.tryParse(s);
                  //           if (val != null) {
                  //             final prefs = PrefsService.instance;
                  //             prefs.setDouble('totalSlugPoints', val);
                  //             if (val == 27182818.0) {
                  //               changeAdVar(false);
                  //             } else if (val == 31415926.0) {
                  //               changeAdVar(true);
                  //             }
                  //           }
                  //         },
                  //         icon: Icon(
                  //           LucideIcons.wallet,
                  //           color: Theme.of(context).colorScheme.onPrimary,
                  //         ),
                  //         keyboardType: const TextInputType.numberWithOptions(
                  //             decimal: true),
                  //       ),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         if (balance != null) {
                  //           final prefs = PrefsService.instance;
                  //           prefs.setDouble('totalSlugPoints', balance);
                  //           setState(() {
                  //             totalSlugPointsController.text =
                  //                 balance.toString();
                  //           });
                  //         }
                  //       },
                  //       icon: Icon(
                  //         LucideIcons.refresh_ccw,
                  //         color: Theme.of(context).colorScheme.onPrimary,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: dateController,
                    label: "Last Day",
                    hint: "Pick a date",
                    onChanged: (s) {
                      setState(() {});
                    },
                    icon: Icon(
                      LucideIcons.calendar,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    isReadOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              datePickerTheme: DatePickerThemeData(
                                headerBackgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                headerForegroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              colorScheme: ColorScheme.dark(
                                primary: Theme.of(context).colorScheme.primary,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.parse(dateController.text),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && context.mounted) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                        PrefsService.instance
                            .setString('lastChosenDate', formattedDate);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: mealCostController,
                          onChanged: (s) {
                            setState(() {});
                            double? val = double.tryParse(s);
                            if (val != null) {
                              final prefs = PrefsService.instance;
                              prefs.setDouble('mealCost', val);
                            }
                          },
                          label: 'Meal Cost',
                          hint: 'Cost',
                          icon: Icon(
                            LucideIcons.circle_dollar_sign,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          controller: mealDayController,
                          onChanged: (s) {
                            setState(() {});
                            double? val = double.tryParse(s);
                            if (val != null) {
                              final prefs = PrefsService.instance;
                              prefs.setDouble('mealDay', val);
                            }
                          },
                          label: 'Meals per day',
                          hint: 'Meals',
                          icon: Icon(
                            LucideIcons.utensils,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 7, 14, 14),
                      child: SummaryWidget(
                        totalSlugPointsController: totalSlugPointsController,
                        mealDayController: mealDayController,
                        mealCostController: mealCostController,
                        dateController: dateController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _timeModalBottom(context) {
  showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    ),
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 30, left: 30, right: 30),
          child: Column(children: [
            const Text(
              "How to Use",
              style: TextStyle(
                fontFamily: constants.bodyFont,
                fontWeight: FontWeight.bold,
                fontSize: constants.titleFontSize,
                color: Colors.black,
                height: constants.bodyFontheight,
              ),
            ),
            Row(children: [
              const Spacer(),
              const Text(
                "Now with",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "images/get_icon.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Mobile!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
            ]),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                text: 'Input or sync with your ',
                children: [
                  TextSpan(
                      text: 'GET Mobile ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary)),
                  const TextSpan(
                    text: "slug points balance.\n\nEnter the",
                  ),
                  TextSpan(
                      text: ' date ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary)),
                  const TextSpan(
                      text: 'the quarter ends.\n\nEstimate how many'),
                  TextSpan(
                      text: ' meals per day ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary)),
                  const TextSpan(
                      text:
                          'you plan to eat. We\'ll let you know if you\'ll have any leftover meals!\n\nFinally, make sure the'),
                  TextSpan(
                      text: ' meal cost ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary)),
                  const TextSpan(
                      text:
                          'is accurate.\n\nToggle between the paragraph and simplified list to see how many meals per day you can eat.\n\nNote: These estimates do not account for the lower prices during finals week.'),
                ],
              ),
            ),
          ])),
    ),
  );
}
