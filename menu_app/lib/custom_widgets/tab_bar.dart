import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) selectIndex;
  const CustomTabBar({
    required this.selectedIndex,
    super.key,
    required this.selectIndex,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
        width: width,
        height: 30, // Adjust the height as needed
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Button(
                  text: "Breakfast",
                  index: 0,
                  selectedIndex: selectedIndex,
                  selectIndex: selectIndex),
              _Button(
                  text: "Lunch",
                  index: 1,
                  selectedIndex: selectedIndex,
                  selectIndex: selectIndex),
              _Button(
                  text: "Dinner",
                  index: 2,
                  selectedIndex: selectedIndex,
                  selectIndex: selectIndex),
              _Button(
                  text: "Late Night",
                  index: 3,
                  selectedIndex: selectedIndex,
                  selectIndex: selectIndex),
              //_Button(text: AppLocalizations.of(context)!.oldTab, index: 3),
            ],
          ),
        ));
  }
}

class _Button extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final void Function(int) selectIndex;

  const _Button(
      {required this.text,
      required this.index,
      required this.selectedIndex,
      required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () => selectIndex(index),
      child: SizedBox(
          width: width * 0.23,
          child: Center(
              child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isActive
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.inverseSurface,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ))),
    );
  }
}
