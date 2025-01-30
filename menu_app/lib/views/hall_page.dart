// Page to load the Side Navagation Bar.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/custom_widgets/menu.dart';
import 'package:menu_app/views/time_modal_widget.dart';
// import 'package:provider/provider.dart';
import '../utilities/constants.dart' as constants;

class MenuPage extends StatefulWidget {
  final constants.Colleges college;
  const MenuPage({required this.college, super.key});

  // Not sure if this should be changed here. TickerProviderStateMixin is weird...
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _dropdownValues = ["Today", "Tomorrow", "Day After"];
  final List<String> _meals = ["Breakfast", "Lunch", "Dinner"];
  String _currentlySelected = "Today";
  void changeDay(String day) {
    setState(() {
      _currentlySelected = day;
    });
  }

  int _getInitTab() {
    final time = DateTime.now();
    if (time.hour < 10) {
      return 0;
    } else if (time.hour < 16) {
      return 1;
    } else if (time.hour < 20) {
      return 2;
    } else {
      return widget.college.hasLateNight ? 3 : 2;
    }
  }

  @override
  void initState() {
    if (widget.college.hasLateNight) {
      _meals.add("Late Night");
    }
    _tabController = TabController(
        length: widget.college.hasLateNight ? 4 : 3,
        vsync: this,
        initialIndex: _getInitTab());
    super.initState();
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Hours info tab.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _timeModalBottom(context, widget.college.name);
          },
          shape: const CircleBorder(),
          enableFeedback: true,
          backgroundColor: const Color.fromARGB(255, 94, 94, 94),
          child: const Icon(
            Icons.access_time_outlined,
            color: Colors.white,
          ),
        ),

        // App heading.
        appBar: AppBar(
          title: Text(
            widget.college.name,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: constants.menuHeadingSize,
                fontFamily: 'Monoton',
                color: Theme.of(context).colorScheme.primary),
          ),
          toolbarHeight: 60,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          // shape: const Border(
          //     bottom: BorderSide(color: Colors.orange, width: 4)),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: constants.backArrowSize),
          ),

          // Choose later date
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    padding: const EdgeInsets.only(right: 10),
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: const Color.fromARGB(255, 37, 37, 37),
                    value: _currentlySelected,
                    alignment: Alignment.center,
                    onChanged: (newValue) {
                      changeDay(newValue ?? "Today");
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return _dropdownValues.map<Widget>((String item) {
                        // This is the widget that will be shown when you select an item.
                        // Here custom text style, alignment and layout size can be applied
                        // to selected item string.
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: const TextStyle(
                                color: Color(constants.bodyColor),
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList();
                    },
                    items: _dropdownValues.map((date) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerLeft,
                        value: date,
                        child: Text(
                          date,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],

          bottom: TabBar(
            dividerColor: Theme.of(context).colorScheme.secondary,
            dividerHeight: 2,
            indicator:
                CustomTabIndicator(Theme.of(context).colorScheme.secondary),
            labelColor: const Color(constants.bodyColor),
            unselectedLabelColor: const Color(constants.bodyColor),
            indicatorSize: TabBarIndicatorSize.tab,
            splashBorderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            controller: _tabController,
            tabs: <Widget>[
              const Tab(
                icon: Icon(Icons.egg_alt_outlined),
              ),
              const Tab(
                icon: Icon(Icons.fastfood_outlined),
              ),
              const Tab(
                icon: Icon(Icons.dinner_dining_outlined),
              ),
              if (widget.college.hasLateNight)
                const Tab(
                  icon: Icon(
                    Icons.bedtime_outlined,
                  ),
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _meals.map((meal) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: MealDisplayWidegt(
                  hallName: widget.college.name,
                  mealTime: meal,
                  day: _currentlySelected,
                ));
          }).toList(),
        ));
  }
}

// Displays Hall default weekly hours.
void _timeModalBottom(context, String name) {
  showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      context: context,
      builder: (BuildContext context) {
        return TimeModalWidget(
          width: MediaQuery.sizeOf(context).width,
          name: name,
        );
      });
}

class CustomTabIndicator extends Decoration {
  final Color color;
  const CustomTabIndicator(this.color);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(color);
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  const _CustomPainter(this.color);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    const double indicatorHeight = 4;
    const double radius = indicatorHeight / 2;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromPoints(
          rect.bottomLeft,
          rect.bottomRight.translate(0, -indicatorHeight),
        ),
        topLeft: const Radius.circular(radius),
        topRight: const Radius.circular(radius),
      ),
      paint,
    );
  }
}
