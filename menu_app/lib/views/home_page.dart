// Loads the Summary Page to display College tiles and Summary below.

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:menu_app/custom_widgets/summary.dart';
import 'package:menu_app/custom_widgets/tab_bar.dart';
// import 'package:menu_app/providers/get_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/views/nav_drawer.dart';
import 'package:menu_app/controllers/home_page_controller.dart';
import 'package:menu_app/custom_widgets/banner.dart' as banner;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageController(context: context),
      builder: (context, child) {
        // Needs to be built before showing the update dialog
        double iconSizeCollege = MediaQuery.of(context).size.width / 2.5;

        return Scaffold(
          // Display app bar header.
          drawer: const NavDrawer(),
          appBar: AppBar(
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: const Icon(Icons.menu),
            //       color: Colors.white, // Change this to your desired color
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //     );
            //   },
            // ),
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
          // floatingActionButton: riverpod.Consumer(
          //   builder: (context, ref, child) {
          //     return FloatingActionButton(
          //       onPressed: () => ref
          //           .read(getNavigationHandlerProvider.notifier)
          //           .handleSessionCheck(context),
          //       backgroundColor: Theme.of(context).colorScheme.primary,
          //       child: SvgPicture.asset('icons/barcode.svg'),
          //     );
          //   },
          // ),

          body: RefreshIndicator(
            onRefresh:
                Provider.of<HomePageController>(context, listen: false).refresh,
            // indicatorBuilder: (context, controller) {
            // return const Icon(
            //   Icons.fastfood_outlined,
            //   color: Colors.blueGrey,
            //   size: 30,
            // );
            // return Image.asset(
            //   'images/slug.png',
            //   scale: 0.5,
            // );
            // },
            child: Consumer<HomePageController>(
              builder: (context, controller, child) => Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        // buildBanner(),
                        const banner.Banner(),
                        // Display header text.
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 12),
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
                            itemCount: controller.colleges.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: _HallIcon(
                                        icon:
                                            'images/${controller.colleges[index].trim()}.png',
                                        onPressed: () {
                                          context.push(
                                              '/${controller.colleges[index].trim()}');
                                        },
                                        size: iconSizeCollege));
                              } else if (index ==
                                  controller.colleges.length - 1) {
                                return Padding(
                                    padding: const EdgeInsets.only(right: 7),
                                    child: _HallIcon(
                                        icon:
                                            'images/${controller.colleges[index].trim()}.png',
                                        onPressed: () {
                                          context.push(
                                              '/${controller.colleges[index].trim()}');
                                        },
                                        size: iconSizeCollege));
                              }
                              return _HallIcon(
                                  icon:
                                      'images/${controller.colleges[index].trim()}.png',
                                  onPressed: () {
                                    context.push(
                                        '/${controller.colleges[index].trim()}');
                                  },
                                  size: iconSizeCollege);
                            },
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 6, top: 6),
                            child: CustomTabBar()),
                        buildSummaryList(controller.colleges,
                            controller.mealTime, controller.busyness),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Last updated: ${Provider.of<HomePageController>(context, listen: false).time.toString().substring(5, 19)}\nData provided by nutrition.sa.ucsc.edu",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class _ extends StatelessWidget {
//   const _({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

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
