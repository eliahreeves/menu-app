// Loads the Summary Page to display College tiles and Summary below.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/custom_widgets/summary.dart';
import 'package:menu_app/custom_widgets/tab_bar.dart';
import 'package:menu_app/custom_widgets/update_dialog.dart';
import 'package:menu_app/models/version.dart';
import 'package:menu_app/providers/ad_state_provider.dart';
import 'package:menu_app/providers/banner_text_provider.dart';
import 'package:menu_app/providers/college_list_provider.dart';
import 'package:menu_app/providers/get_mobile_fab_status.dart';
import 'package:menu_app/providers/meal_album_provider.dart';
import 'package:menu_app/providers/summary_list_provider.dart';
import 'package:menu_app/providers/update_time_provider.dart';
import 'package:menu_app/providers/waitz_crowd_status.dart';
import 'package:menu_app/views/error_widget.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:menu_app/views/get_mobile_page.dart';
// import 'package:provider/provider.dart' as prov;
import 'package:go_router/go_router.dart';
import 'package:menu_app/views/nav_drawer.dart';
import 'package:menu_app/custom_widgets/banner.dart' as banner;
import 'package:flutter_lucide/flutter_lucide.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late int _index;
  void _setIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  String _getMealTime(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';

      case 1:
        return 'Lunch';

      case 2:
        return 'Dinner';

      case 3:
        return 'Late Night';

      case 4:
        return 'Null';
      default:
        return 'Late Night';
    }
  }

  void _loadMealTime() {
    DateTime time = DateTime.now();
    if (time.hour <= 4 || time.hour >= 23) {
      _index = 4; // will not highlight a button time
    } else if (time.hour < 11 && time.hour > 4) {
      _index = 0;
    } else if (time.hour < 16) {
      _index = 1;
    } else if (time.hour < 20) {
      _index = 2;
    } else if (time.hour < 23) {
      _index = 3;
    }
  }

  @override
  void initState() {
    _loadMealTime();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!await performVersionCheck()) {
        if (mounted) {
          showUpdateDialog(context);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colleges = ref.watch(collegeListProvider);
    final getMobileFabStatus = ref.watch(getMobileFabStatusProvider);

    double iconSizeCollege = MediaQuery.of(context).size.width / 2.5;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(LucideIcons.menu)),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: const Color.fromARGB(255, 60, 60, 60),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "UC Santa Cruz",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 30,
              fontFamily: 'Monoton',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        shape: Border(
            bottom: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 4)),
      ),
      floatingActionButton: getMobileFabStatus
          ? FloatingActionButton(
              onPressed: () async {
                ref
                    .read(adStateNotifierProvider.notifier)
                    .updateAdState(isEnabled: false);
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const GetMobilePage(),
                  ),
                ).then((_) => ref
                    .read(adStateNotifierProvider.notifier)
                    .updateAdState(isEnabled: true));
                // showOverlay(context); // Show the overlay first
                // await Future.delayed(const Duration(seconds: 2));
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              child: const Icon(LucideIcons.scan_barcode),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(summaryListDataProvider);
          ref.invalidate(mealAlbumProvider);
          await Future.wait([
            ref.read(summaryListDataProvider(_getMealTime(_index)).future),
            ref.refresh(waitzCrowdStatusProvider.future),
            ref.refresh(bannerTextProvider.future),
            ref.refresh(updateTimeProvider.future),
          ]);
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  // buildBanner(),
                  const banner.Banner(),
                  // Display header text.
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Dining Halls",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  // Display all hall icons.
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.width / 2.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colleges.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: _HallIcon(
                                  icon: 'images/${colleges[index].id}.png',
                                  onPressed: () {
                                    context.push(colleges[index].pathName);
                                  },
                                  size: iconSizeCollege));
                        } else if (index == colleges.length - 1) {
                          return Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: _HallIcon(
                                  icon: 'images/${colleges[index].id}.png',
                                  onPressed: () {
                                    context.push(colleges[index].pathName);
                                  },
                                  size: iconSizeCollege));
                        }
                        return _HallIcon(
                            icon: 'images/${colleges[index].id}.png',
                            onPressed: () {
                              context.push(colleges[index].pathName);
                            },
                            size: iconSizeCollege);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 6, top: 6),
                      child: CustomTabBar(
                        selectedIndex: _index,
                        selectIndex: _setIndex,
                      )),
                  SummaryList(mealTime: _getMealTime(_index)),
                  const _Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateTime = ref.watch(updateTimeProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text(
            "Last updated: ${updateTime.hasValue ? updateTime.value : "Unknown"}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const Text(
            "Data provided by nutrition.sa.ucsc.edu",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          FutureBuilder(
            future: getCurrentAppVersion(),
            builder: (context, snapshot) => Text(
              (snapshot.hasData)
                  ? "${snapshot.data!.version}+${snapshot.data!.buildNumber}"
                  : "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}

class _HallIcon extends StatelessWidget {
  final void Function() onPressed;
  final double size;
  final String icon;
  const _HallIcon(
      {required this.onPressed, required this.size, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child: SizedBox(
                  width: size, height: size, child: Image.asset(icon)))),
      iconSize: size,
    );
  }
}
