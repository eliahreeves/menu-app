import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:menu_app/utilities/prefs_service.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isReadOnly;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Widget? icon;
  final GestureTapCallback? onTap;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isReadOnly = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        hintText: hint,
        prefixIcon: icon,
        fillColor: Theme.of(context).colorScheme.onSurfaceVariant,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            // color:
            //     Theme.of(context).colorScheme.primary.withValues(alpha: 0.75),
            // FIXME sorry had to change to deprecated withOpacity because i get same bug as https://github.com/mapbox/mapbox-maps-flutter/issues/811
            color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
          ),
        ),
      ),
    );
  }
}

class SummaryWidget extends StatefulWidget {
  final TextEditingController totalSlugPointsController;
  final TextEditingController mealDayController;
  final TextEditingController mealCostController;
  final TextEditingController dateController;

  const SummaryWidget({
    super.key,
    required this.totalSlugPointsController,
    required this.mealDayController,
    required this.mealCostController,
    required this.dateController,
  });

  @override
  _SummaryWidgetState createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  late bool _isDetailedView;
  final prefs = PrefsService.instance;

  num getDays() {
    return num.parse(
      (DateTime.parse(widget.dateController.text)
                  .difference(DateTime.now())
                  .inDays +
              1)
          .toString(),
    );
  }

  double getTotalSlugPoints() {
    return double.tryParse(widget.totalSlugPointsController.text) ?? 1000.0;
  }

  double getMealDay() {
    return double.tryParse(widget.mealDayController.text) ?? 3.0;
  }

  double getMealCost() {
    return double.tryParse(widget.mealCostController.text) ?? 12.23;
  }

  String getMealAmount() {
    return ((getTotalSlugPoints() -
                (getMealDay() * getMealCost() * getDays())) /
            getMealCost())
        .toStringAsFixed(2);
  }

  String getPointsAmount() {
    return ((getTotalSlugPoints() - (getMealDay() * getMealCost() * getDays())))
        .toStringAsFixed(2);
  }

  String getMealDayAmount() {
    return (((getTotalSlugPoints() / getMealCost()) / getDays()))
        .toStringAsFixed(2);
  }

  void _toggleView() {
    setState(() {
      _isDetailedView = !_isDetailedView;
    });
    prefs.setBool('calc_is_detailed_view', _isDetailedView);
  }

  @override
  void initState() {
    super.initState();
    _isDetailedView = prefs.getBool('calc_is_detailed_view') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Summary",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: _toggleView,
              icon: _isDetailedView
                  ? const Icon(LucideIcons.list)
                  : const Icon(LucideIcons.align_left),
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _isDetailedView
            ? DetailedSummary(
                daysLeft: getDays().toString(),
                extraMeals: getMealAmount(),
                extraPoints: getPointsAmount(),
                mealsPerDay: getMealDayAmount())
            : SimpleSummary(
                daysLeft: getDays().toString(),
                extraMeals: getMealAmount(),
                extraPoints: getPointsAmount(),
                mealsPerDay: getMealDayAmount()),
      ],
    );
  }
}

class DetailedSummary extends StatelessWidget {
  final String daysLeft;
  final String extraMeals;
  final String extraPoints;
  final String mealsPerDay;

  const DetailedSummary({
    super.key,
    required this.daysLeft,
    required this.extraMeals,
    required this.extraPoints,
    required this.mealsPerDay,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        text: 'There are ',
        children: [
          TextSpan(
              text: daysLeft,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.secondary)),
          TextSpan(
              text: ' days left in the quarter.\n\nYou have ',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          TextSpan(
              text: extraMeals,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.secondary)),
          const TextSpan(text: ' extra meals and '),
          TextSpan(
              text: extraPoints,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.secondary)),
          const TextSpan(text: ' slug points to spend.\n\nYou can eat '),
          TextSpan(
              text: mealsPerDay,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.secondary)),
          const TextSpan(text: ' meals every day.'),
        ],
      ),
    );
  }
}

class SimpleSummary extends StatelessWidget {
  final String daysLeft;
  final String extraMeals;
  final String extraPoints;
  final String mealsPerDay;

  const SimpleSummary({
    super.key,
    required this.daysLeft,
    required this.extraMeals,
    required this.extraPoints,
    required this.mealsPerDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Days Left", style: TextStyle(fontSize: 20)),
            Text(daysLeft,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Extra Meals", style: TextStyle(fontSize: 20)),
            Text(extraMeals,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Slug Points", style: TextStyle(fontSize: 20)),
            Text(extraPoints,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Meals/Day", style: TextStyle(fontSize: 20)),
            Text(mealsPerDay,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      ],
    );
  }
}
